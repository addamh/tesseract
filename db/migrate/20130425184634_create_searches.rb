class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.integer :skill_id

      t.timestamps
    end
  end
end
