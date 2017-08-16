class AddRecipientToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :recipient, :string
  end
end
