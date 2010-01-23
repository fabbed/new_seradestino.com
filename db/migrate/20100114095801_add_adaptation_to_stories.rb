class AddAdaptationToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :experiment_story, :boolean, :default => false
  end

  def self.down
    remove_column :stories, :experiment_story
  end
end
