class AddStatusToBrands < ActiveRecord::Migration
  def change
  	add_column :brands, :status, :string
  	add_column :brands, :published_at, :datetime
  end
end
