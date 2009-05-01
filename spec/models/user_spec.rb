require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = User.make
    @id = @user.id
  end

  it "should create a new instance given valid attributes" do
    User.find(@id).should == @user
  end
  
  context "with a watched area" do
     before(:each) do
       @area = Area.make
       @watched_area = WatchedArea.make(:area => @area)
       @user.watched_areas << @watched_area
     end
     
     it "find the watched area" do
       @user.watched_areas.first.should == @watched_area
       @user.areas.first.should == @area
     end
   end
end

# == Schema Information
# Schema version: 20090501121320
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
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :timestamp
#

