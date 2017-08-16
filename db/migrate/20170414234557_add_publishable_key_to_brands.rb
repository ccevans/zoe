class AddPublishableKeyToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :publishable_key, :string
  end
end
