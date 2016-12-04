class Sale < ApplicationRecord
  belongs_to :purchaser
  belongs_to :item

  delegate :name,                to: :purchaser, prefix: true
  delegate :description, :price, to: :item,      prefix: true
  delegate :address, :name,      to: :merchant,  prefix: true

  def self.csv_import(file)
    CSV.foreach(file.path, headers: true) do |row|
      sale = new

      save_purchase_count(sale: sale, row: row)
      save_purchaser_data(sale: sale, row: row)
      save_item_data(sale: sale, row: row)

      sale.save
    end
  end

  private

  def self.save_purchase_count(sale:, row:)
    sale.update(purchase_count: row['purchase count'])
  end

  def self.save_purchaser_data(sale:, row:)
    sale.purchaser = Purchaser.where(name: row['purchaser name']).first_or_create
  end

  def self.save_item_data(sale:, row:)
    sale.item = Item.where(description: row['item description'], price: row['item price']).first_or_create
  end
end
