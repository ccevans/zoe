class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :user_id
      t.string :stripe_id
      t.boolean :creditactive, :default => false

      t.timestamps null: false
    end

    add_index :credits, :stripe_id, unique: true
  end
end
