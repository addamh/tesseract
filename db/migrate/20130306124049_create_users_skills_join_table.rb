class CreateUsersSkillsJoinTable < ActiveRecord::Migration
  def up
    create_table :skills_users, :id => false do |t|
        t.integer :user_id
        t.integer :skill_id
    end

    add_index :skills_users, [:user_id, :skill_id]
  end

  def down
    drop_table :skills_users
  end
end
