class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :title
      t.string :location
      t.date :achieved

      t.timestamps
    end
  end
end
