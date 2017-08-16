class RemoveAddressDefaultFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :address_default, :boolean
  end
end
