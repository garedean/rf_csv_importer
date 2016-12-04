class AddPurchaseCountToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :purchase_count, :integer
  end
end
