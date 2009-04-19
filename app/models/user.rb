class User < ActiveRecord::Base
  
  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
    c.logged_in_timeout = 30.minutes
  end
  
end
