class AddAvatarsClickedToVisitorSessions < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :avatars_clicked, :text
  end

  def self.down
    remove_column :visitor_sessions, :avatars_clicked
  end
end
