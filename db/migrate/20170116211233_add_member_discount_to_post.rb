class AddMemberDiscountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :member_discount, :string, :default => 0
  end
end
