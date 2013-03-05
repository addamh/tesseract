class User < ActiveRecord::Base
  has_many  :services
  has_many  :skills
  has_many  :credentials
  has_one   :profile
  has_one   :availability_status
  
  accepts_nested_attributes_for :profile
  
  attr_accessible :name, :email, :username, :last_seen, :avatar_url, :profile_attributes
  validates_presence_of :name, :email
  validates_uniqueness_of :email
    
  def edit
    @profile = current_user.profile
  end
  
  def profile
    @profile
  end
end
