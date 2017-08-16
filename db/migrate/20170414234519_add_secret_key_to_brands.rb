class AddSecretKeyToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :secret_key, :string
  end
end
