class AddStoriesOrderToVisitorSession < ActiveRecord::Migration
  def self.up
    add_column :visitor_sessions, :stories_order, :text
  end

  def self.down
    remove_column :visitor_sessions, :stories_order
  end
end
