class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resume, :binary
    add_column :users, :website, :string
    add_column :users, :pref_payment, :string
    add_column :users, :rate, :integer
    add_column :users, :note, :text
    add_column :users, :points, :integer
    add_column :users, :contacts, :integer
    add_column :users, :views, :integer
  end
end
