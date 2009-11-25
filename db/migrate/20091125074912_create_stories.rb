class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.text        :body
      t.string      :title, :limit => 100
      t.string      :seo_title
      t.string      :email
      t.integer     :rated_top, :default => 0
      t.integer     :rated_flop, :default => 0
      t.boolean     :anonymous, :default => true
      t.boolean     :on_startpage, :default => false
      t.integer     :rated_top, :default => 0
      t.integer     :rated_flop, :default => 0
      t.belongs_to  :category
      t.belongs_to  :user
      t.belongs_to  :location
      t.belongs_to  :country

      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
