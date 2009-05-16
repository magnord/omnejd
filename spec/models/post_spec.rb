require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @post = Post.make
    @id = @post.id
  end

  it "should create a new instance given valid attributes" do
    @post = Post.find(@id)
  end
end

# == Schema Information
# Schema version: 20090501121320
#
# Table name: posts
#
#  id              :integer         not null, primary key
#  title           :string(255)
#  body            :text
#  user_id         :integer
#  created_at      :timestamp
#  updated_at      :timestamp
#  cached_tag_list :string(255)
#  pos             :geometry        not null, point, -1
#

