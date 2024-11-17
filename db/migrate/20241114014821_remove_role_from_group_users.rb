class RemoveRoleFromGroupUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_users, :role, :varchar
  end
end
