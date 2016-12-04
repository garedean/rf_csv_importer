class Sale < ApplicationRecord
  belongs_to :purchaser

  delegate :name,               to: :purchaser, prefix: true
  delegate :desciption, :price, to: :item,      prefix: true
  delegate :address, :name,     to: :merchant,  prefix: true

  def self.csv_import(file)
    CSV.foreach(file.path, headers: true) do |row|
      sale = new

      sale.purchase_count = row['purchase count']

      sale.purchaser = Purchaser.first_or_create(name: row['purchaser name'])

      sale.save
    end
  end
end
