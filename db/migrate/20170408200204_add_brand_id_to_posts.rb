class AddBrandIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :brand_id, :integer
  end
end
