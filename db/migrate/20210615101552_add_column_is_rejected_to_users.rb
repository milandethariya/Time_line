class AddColumnIsRejectedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_rejected, :boolean, :default => true
  end
end
