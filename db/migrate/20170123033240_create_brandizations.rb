class CreateBrandizations < ActiveRecord::Migration
  def change
    create_table :brandizations do |t|
      t.integer :post_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
