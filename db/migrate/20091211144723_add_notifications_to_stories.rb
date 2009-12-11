class AddNotificationsToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :notifications, :boolean, :default => true
  end

  def self.down
    remove_column :stories, :notifications
  end
end
