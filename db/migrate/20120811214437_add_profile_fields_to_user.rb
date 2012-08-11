class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
    add_column :users, :foursquare, :string
    add_column :users, :googleplus, :string
    add_column :users, :homepage, :string
    add_column :users, :phone, :string
    add_column :users, :company, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
