class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :last_seen, :datetime
  end
end
