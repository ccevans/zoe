class AddOrderIdToCredit < ActiveRecord::Migration
  def change
    add_column :credits, :order_id, :integer
  end
end
