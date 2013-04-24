class AddAttachmentResumeToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :resume
    end
  end

  def self.down
    drop_attached_file :users, :resume
  end
end
