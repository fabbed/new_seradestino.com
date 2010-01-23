class AddCompleteToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :complete, :boolean, :default => false
  end

  def self.down
    remove_column :stories, :complete
  end
end
