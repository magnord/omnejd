class User < ActiveRecord::Base
  
  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
    c.logged_in_timeout = 30.minutes
    c.perishable_token_valid_for = 30.minutes
  end
  
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end
  
end
