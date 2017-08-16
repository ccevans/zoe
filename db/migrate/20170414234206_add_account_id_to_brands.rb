class AddAccountIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :account_id, :string
  end
end
