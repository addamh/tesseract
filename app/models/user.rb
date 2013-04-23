class User < ActiveRecord::Base
  has_many  :services
  has_and_belongs_to_many  :skills
  has_many  :credentials
  has_one   :availability_status

  accepts_nested_attributes_for :skills, :credentials
    
  attr_accessible :name, :email, :username, :last_seen, :avatar_url, :profile, :contacts, :note, :points, :pref_payment, :rate, :resume, :type, :views, :website, :skills_attributes, :skill_ids, :credentials_attributes
  
  validates_presence_of :name, :username, :email
  validates_uniqueness_of :email, :username
end
