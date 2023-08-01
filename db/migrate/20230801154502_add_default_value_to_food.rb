class AddDefaultValueToFood < ActiveRecord::Migration[7.0]
  def change
    change_column_default :foods, :price, 0
    change_column_default :foods, :quantity, 0
  end
end
