class CreateAreaUserJoinTable < ActiveRecord::Migration
  def self.up
     create_table :areas_users, :id => false do |t| 
       t.integer :area_id  
       t.integer :user_id
      end 
  end

  def self.down
    drop_table :areas_users
  end
end
