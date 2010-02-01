class AddAjaxOnLoadTimeToVisitorSessions < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :ajax_on_load_time, :datetime
  end

  def self.down
    remove_column :visitor_sessions, :ajax_on_load_time, :datetime    
  end
end


