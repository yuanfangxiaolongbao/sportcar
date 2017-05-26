class AddSaleQuantity < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :sale_quantity, :integer, default: 0
  end
end
