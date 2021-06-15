class AddDefaultValueToIsAdminFalse < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :is_activated, :boolean, default: false
  end
end
