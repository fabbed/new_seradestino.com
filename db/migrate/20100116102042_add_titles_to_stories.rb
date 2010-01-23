class AddTitlesToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :title_ne, :string
    add_column :stories, :title_es, :string
    add_column :stories, :title_mx, :string        
  end

  def self.down
    remove_column :stories, :title_ne
    remove_column :stories, :title_es
    remove_column :stories, :title_mx        
  end
end
