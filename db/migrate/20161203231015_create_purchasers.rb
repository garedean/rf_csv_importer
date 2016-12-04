class CreatePurchasers < ActiveRecord::Migration[5.0]
  def change
    create_table :purchasers do |t|
      t.string :name
    end
  end
end
