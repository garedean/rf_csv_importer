class RemoveDecimalFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :decimal, :numeric
  end
end
