class Sale < ApplicationRecord
  belongs_to :purchaser
  belongs_to :item
  belongs_to :merchant

  delegate :name,                to: :purchaser, prefix: true
  delegate :description, :price, to: :item,      prefix: true
  delegate :address, :name,      to: :merchant,  prefix: true

  class << self
    def csv_import(file)
      CSV.foreach(file.path, headers: true) do |row|
        sale = new

        save_purchase_count(sale: sale, row: row)
        save_purchaser_data(sale: sale, row: row)
        save_item_data(sale: sale, row: row)
        save_merchant_data(sale: sale, row: row)

        sale.save
      end
    end

    def revenue_for_all_sales
      eager_load(:item).inject(0) do |total, sale|
        purchase_count = sale.purchase_count
        item_price     = sale.item_price
        sale_total     = purchase_count * item_price

        total += sale_total
      end
    end

    private

    def save_purchase_count(sale:, row:)
      sale.update(purchase_count: row['purchase count'])
    end

    def save_purchaser_data(sale:, row:)
      sale.purchaser = Purchaser.where(name: row['purchaser name']).first_or_create
    end

    def save_item_data(sale:, row:)
      sale.item = Item.where(description: row['item description'], price: row['item price']).first_or_create
    end

    def save_merchant_data(sale:, row:)
      sale.merchant = Merchant.where(address: row['merchant address'], name: row['merchant name']).first_or_create
    end
  end
end
