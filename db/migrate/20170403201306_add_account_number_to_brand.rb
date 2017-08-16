class AddAccountNumberToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :account_number, :string
  end
end
