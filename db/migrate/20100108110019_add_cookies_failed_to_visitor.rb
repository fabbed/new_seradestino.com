class AddCookiesFailedToVisitor < ActiveRecord::Migration
  def self.up
    add_column :visitors, :cookies_failed, :boolean, :default => false
  end

  def self.down
    remove_column :visitors, :cookies_failed
  end
end
