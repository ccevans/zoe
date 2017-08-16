class AddShippingPriceToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :shipping_price, :string
  end
end
