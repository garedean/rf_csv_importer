class Sale < ApplicationRecord
  belongs_to :purchaser
  belongs_to :item
  belongs_to :merchant

  delegate :name,                to: :purchaser, prefix: true, allow_nil: true
  delegate :description, :price, to: :item,      prefix: true, allow_nil: true
  delegate :address, :name,      to: :merchant,  prefix: true, allow_nil: true

  class << self
    def csv_import(file)
      batch_sale_revenue = 0

      CSV.foreach(file.path, headers: true) do |row|
        sale = new

        save_sale_attributes(sale: sale, row: row)
        batch_sale_revenue += calculate_single_sale_revenue_from_row(row)

        sale.save
      end

      batch_sale_revenue
    end

    def revenue_for_all_sales
      eager_load(:item).inject(0) { |total, sale| total += revenue_from_single_sale(sale) }
    end

    private

    def calculate_single_sale_revenue_from_row(row)
      row['item price'].to_i * row['purchase count'].to_i
    end

    def revenue_from_single_sale(sale)
      sale.item_price * sale.purchase_count
    end

    def save_sale_attributes(sale:, row:)
      save_purchase_count(sale: sale, row: row)
      save_purchaser_data(sale: sale, row: row)
      save_item_data(sale: sale, row: row)
      save_merchant_data(sale: sale, row: row)
    end

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
