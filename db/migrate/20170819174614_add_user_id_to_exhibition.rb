class AddUserIdToExhibition < ActiveRecord::Migration
  def change
    add_column :exhibitions, :user_id, :integer
  end
end
