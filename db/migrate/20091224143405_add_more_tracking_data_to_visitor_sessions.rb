class AddMoreTrackingDataToVisitorSessions < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :user_id, :integer
    add_column :visitor_sessions, :newsletter, :boolean, :default => false
    add_column :visitor_sessions, :stories_read, :text
  end

  def self.down
    remove_column :visitor_sessions, :stories_read
    remove_column :visitor_sessions, :newsletter
    remove_column :visitor_sessions, :user_id
  end
end
