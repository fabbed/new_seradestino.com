class AddCountryNameToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :country_name, :string
  end

  def self.down
    remove_column :locations, :country_name
  end
end
