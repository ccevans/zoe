class AddBrandIdsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :brand_ids, :text, array: true, default: []
  end
end
