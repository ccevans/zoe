class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
