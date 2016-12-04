class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :description
      t.decimal :price, :decimal, :precision => 8, :scale => 2
    end
  end
end
