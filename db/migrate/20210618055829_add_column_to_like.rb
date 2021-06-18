class AddColumnToLike < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :is_like, :boolean
  end
end
