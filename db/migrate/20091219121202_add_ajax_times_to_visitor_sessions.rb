class AddAjaxTimesToVisitorSessions < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :ajax_created_at, :datetime
    add_column :visitor_sessions, :ajax_updated_at, :datetime
  end

  def self.down
    remove_column :visitor_sessions, :ajax_created_at
    remove_column :visitor_sessions, :ajax_updated_at    
  end
end
