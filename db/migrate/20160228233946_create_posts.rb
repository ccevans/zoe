class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :brand
      t.text :title
      t.text :link
      t.string :price
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
