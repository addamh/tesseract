class AddAvailabilityToUser < ActiveRecord::Migration
  def change
    add_column :users, :availability, :text
  end
end
