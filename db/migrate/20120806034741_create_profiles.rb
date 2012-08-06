class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :type
      t.integer :views
      t.integer :contacts
      t.integer :points
      t.text :note
      t.integer :rate
      t.string :pref_payment
      t.string :website
      t.binary :resume

      t.timestamps
    end
  end
end
