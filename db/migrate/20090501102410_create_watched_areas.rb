class CreateWatchedAreas < ActiveRecord::Migration
  def self.up
    create_table :watched_areas do |t|
      t.references :user
      t.references :area

      t.timestamps
    end
    drop_table :areas_users
  end

  def self.down
    drop_table :watched_areas
  end
end
