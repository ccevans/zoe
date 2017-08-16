class AddAddressDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_id, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :street_address, :text
    add_column :users, :street_address2, :text
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :string
  end
end
