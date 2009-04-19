class CreateAreas < ActiveRecord::Migration
  
  def self.up
    create_table :areas do |t|
      t.string :name
      t.references :user
      t.polygon :geom, :null => false
      
      t.timestamps
    end
    
    # Add spatial index
    add_index "areas", "geom", :spatial => true
  end

  def self.down
    drop_table :areas
  end
end
