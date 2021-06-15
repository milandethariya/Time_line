class RenameUserAdminToIsAdmin < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :admin, :is_admin
  	rename_column :users, :activate, :is_activated
  end
end
