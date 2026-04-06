class AddProfileFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :avatar, :string
    add_column :users, :address, :string
    add_column :users, :latitude, :decimal
    add_column :users, :longitude, :decimal
  end
end
