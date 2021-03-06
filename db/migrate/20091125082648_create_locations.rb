class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.float         :lng, :limit => 8
      t.float         :lat, :limit => 8      
      t.belongs_to    :country
      t.string        :city
      t.string        :precision
      t.string        :country_code
      t.belongs_to    :locatable
    end
  end

  def self.down
    drop_table :locations
  end
end
