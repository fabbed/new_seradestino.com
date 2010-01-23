class AddNeutralSpanishMexicanToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :body_ne, :text
    add_column :stories, :body_es, :text
    add_column :stories, :body_mx, :text
  end

  def self.down
    remove_column :stories, :body_ne
    remove_column :stories, :body_es
    remove_column :stories, :body_mx
  end
  
end
