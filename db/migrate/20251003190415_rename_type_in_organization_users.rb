class RenameTypeInOrganizationUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :organization_users, :type, :type_of
  end
end
