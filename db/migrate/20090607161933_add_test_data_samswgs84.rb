class AddTestDataSamswgs84 < ActiveRecord::Migration
  def self.up
    create_table :samswgs84 do |t|
      t.string :samscode
      t.string :samsnamn
      t.string :kommun
      t.multi_polygon :geom, :null => false

      t.timestamps
    end

    # Add spatial index
    add_index "samswgs84", "geom", :spatial => true
  end

  def self.down
    drop_table :samswgs84
  end
end
