class AddStripeFieldsToBrand < ActiveRecord::Migration
  def change
      add_column :brands, :type, :string
      add_column :brands, :first_name, :string
      add_column :brands, :last_name, :string
      add_column :brands, :street_address, :string
      add_column :brands, :street_address_line2, :string
      add_column :brands, :city, :string
      add_column :brands, :state, :string
      add_column :brands, :postal_code, :string
      add_column :brands, :birth_day, :integer
      add_column :brands, :birth_month, :integer
      add_column :brands, :birth_year, :integer
      add_column :brands, :ssn_last_4, :string
      add_column :brands, :email, :string
      add_column :brands, :phone, :string
      add_column :brands, :website, :string
  end
end
