class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :phone, :string
    add_column :users, :last_logged_in_at, :datetime
    add_column :users, :logged_in_from_ip, :string
  end
end
