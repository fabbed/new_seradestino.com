class AddAvatarUploadedToVisitorSessions < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :avatar_uploaded, :boolean, :default => false
  end

  def self.down
    remove_column :visitor_sessions, :avatar_uploaded
  end
end
