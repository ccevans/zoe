class AddAddressDefaultToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :address_default, :boolean
  end
end
