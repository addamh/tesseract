class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin,          :boolean
    add_column :users, :last_seen,      :timestamp
    add_column :users, :current_avatar, :integer
  end
end
