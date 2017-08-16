class AddRoutingNumberToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :routing_number, :string
  end
end
