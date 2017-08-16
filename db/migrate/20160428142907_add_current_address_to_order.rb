class AddCurrentAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :current_address, :boolean, :default => true
  end
end
