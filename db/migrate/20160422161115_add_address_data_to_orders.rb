class AddAddressDataToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address_id, :integer
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :street_address, :text
    add_column :orders, :street_address2, :text
    add_column :orders, :city, :string
    add_column :orders, :country, :string, :default => "United States"
    add_column :orders, :state, :string
    add_column :orders, :zipcode, :string
  end
end
