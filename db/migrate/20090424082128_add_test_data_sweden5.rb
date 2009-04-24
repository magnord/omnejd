class AddTestDataSweden5 < ActiveRecord::Migration
  def self.up
     create_table :sweden5 do |t|
        t.string :gid, :null => false
        t.string :name
        t.string :name_ascii
        t.multi_polygon :geom, :null => false

        t.timestamps
      end

      # Add spatial index
      add_index "sweden5", "geom", :spatial => true
  end

  def self.down
    drop_table :sweden5
  end
end
