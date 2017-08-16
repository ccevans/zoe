class AddPostIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :post_id, :integer
  end
end
