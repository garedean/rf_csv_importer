class Sale < ApplicationRecord
  belongs_to :purchaser
  belongs_to :item

  delegate :name,                to: :purchaser, prefix: true
  delegate :description, :price, to: :item,      prefix: true
  delegate :address, :name,      to: :merchant,  prefix: true

  def self.csv_import(file)
    CSV.foreach(file.path, headers: true) do |row|
      sale = new

      sale.purchase_count = row['purchase count']

      sale.purchaser = Purchaser.where(name: row['purchaser name']).first_or_create

      sale.item = Item.where(description: row['item description'], price: row['item price']).first_or_create

      sale.save
    end
  end
end
