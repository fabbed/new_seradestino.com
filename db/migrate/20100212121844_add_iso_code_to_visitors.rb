class AddIsoCodeToVisitors < ActiveRecord::Migration
  def self.up
    add_column :visitors, :country_iso, :string
  end

  def self.down
    remove_column :visitors, :column_name
  end
end
