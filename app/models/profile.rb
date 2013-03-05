class Profile < ActiveRecord::Base
  attr_accessible :contacts, :note, :points, :pref_payment, :rate, :resume, :type, :views, :website

  belongs_to :user
end
