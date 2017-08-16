class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.text :street_address
      t.text :street_address2
      t.string :city
      t.string :country, :default => "United States"
      t.string :state
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
