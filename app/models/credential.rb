class Credential < ActiveRecord::Base
  belongs_to :user
  attr_accessible :achieved, :location, :title
end
