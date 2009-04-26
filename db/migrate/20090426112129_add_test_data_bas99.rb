class AddTestDataBas99 < ActiveRecord::Migration
  def self.up
     create_table :bas99 do |t|
        t.string :basnamn
        t.polygon :geom, :null => false

        t.timestamps
      end

      # Add spatial index
      add_index "bas99", "geom", :spatial => true
  end

  def self.down
    drop_table :bas99
  end
end
