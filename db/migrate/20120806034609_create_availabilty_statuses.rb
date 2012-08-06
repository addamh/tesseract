class CreateAvailabiltyStatuses < ActiveRecord::Migration
  def change
    create_table :availabilty_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
