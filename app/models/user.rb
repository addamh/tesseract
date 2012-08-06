class User < ActiveRecord::Base
  has_many  :services
  has_many  :skills
  has_many  :credentials
  has_one   :profile
  has_one   :availability_status
  
  attr_accessible :name, :email, :username, :last_seen, :avatar_url

end
