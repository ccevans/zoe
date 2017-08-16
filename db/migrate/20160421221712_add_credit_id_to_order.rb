class AddCreditIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :credit_id, :integer
  end
end
