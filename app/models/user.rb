# == Schema Information
# Schema version: 20090419181824
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  login               :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :timestamp
#  current_login_at    :timestamp
#  last_login_at       :timestamp
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :timestamp
#  updated_at          :timestamp
#

class User < ActiveRecord::Base
  
  has_many :posts, :dependent => :nullify

  # Watched areas
  has_many :watched_areas, :dependent => :destroy
  has_many :areas, :through => :watched_areas

  # Add a test area to all users (when running in development)
  #after_create :add_test_area

  def add_test_area
    if ENV['RAILS_ENV'] == "development" then 
      watched_areas << WatchedArea.create(:area => Area.test_area)
    end
  end

  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
    c.logged_in_timeout = 30.minutes
    c.perishable_token_valid_for = 30.minutes
  end

  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "50x50>" }


  validates_uniqueness_of :login, :email, :case_sensitive => false
  

  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end

end

