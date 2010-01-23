class AddGoodToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :fab_rating, :integer, :default => 0 #0,1,2,3
  end

  def self.down
    remove_column :stories, :good
  end
end
