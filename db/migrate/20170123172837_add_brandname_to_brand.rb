class AddBrandnameToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :brandname, :string
  end
end
