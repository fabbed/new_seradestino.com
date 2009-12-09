class AddCookieToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :vcode, :string
  end

  def self.down
    remove_column :users, :vcode
  end
end
