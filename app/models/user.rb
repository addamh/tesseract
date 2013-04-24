class User < ActiveRecord::Base
  has_many  :services
  has_and_belongs_to_many  :skills
  has_many  :credentials
  has_one   :availability_status

  accepts_nested_attributes_for :skills, :credentials
    
  # attr_accessible :name, :email, :username, :last_seen, :avatar_url, :profile, :contacts, :note, :points, :pref_payment, :rate, :resume, :type, :views, :website, :skills_attributes, :skill_ids, :credentials_attributes
  attr_accessible :name, :email, :username, :last_seen, :avatar_url, :avatar, :profile, :contacts, :note, :points, :pref_payment, :rate, :resume, :type, :views, :website, :skills_attributes, :skill_ids, :credentials_attributes
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :resume
  validates_presence_of :name, :email
  validates_uniqueness_of :email, :username
  validates_attachment_content_type :resume, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :resume_changed?
end
