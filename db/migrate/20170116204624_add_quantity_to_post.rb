class AddQuantityToPost < ActiveRecord::Migration
  def change
    add_column :posts, :quantity, :integer, :default => 0
  end
end
