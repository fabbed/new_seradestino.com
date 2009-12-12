class AddLocationToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :location_id, :integer
  end

  def self.down
    remove_column :comments, :location_id
  end
end
