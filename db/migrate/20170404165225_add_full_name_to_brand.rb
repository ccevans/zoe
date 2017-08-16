class AddFullNameToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :full_name, :string
  end
end
