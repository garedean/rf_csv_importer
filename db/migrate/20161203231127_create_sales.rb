class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.references :purchaser, foreign_key: true
      t.references :item, foreign_key: true
      t.references :merchant, foreign_key: true
    end
  end
end
