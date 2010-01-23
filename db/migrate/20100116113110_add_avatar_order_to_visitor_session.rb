class AddAvatarOrderToVisitorSession < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :avatars_order, :text
  end

  def self.down
    remove_column :visitor_sessions, :avatars_order
  end
end
