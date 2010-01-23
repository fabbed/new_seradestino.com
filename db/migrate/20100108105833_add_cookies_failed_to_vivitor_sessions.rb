class AddCookiesFailedToVivitorSessions < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :cookies_failed, :boolean, :default => false
  end

  def self.down
    remove_column :visitor_sessions, :cookies_failed
  end
end
