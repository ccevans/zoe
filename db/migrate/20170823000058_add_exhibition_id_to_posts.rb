class AddExhibitionIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :exhibition_id, :integer
  end
end
