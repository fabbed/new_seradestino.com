namespace :exp do

    desc "Remove Tag"
    task :remove_exp_story => :environment do
      Story.find(:all, :conditions => ['fab_rating < ?', 3]).each do |story|
        story.update_attribute(:experiment_story, false)
      end
    end

    desc "Edit Neutral"
    task :mark_exp_stories => :environment do
      Story.find(:all, :conditions => ['experiment_story = ?', true]).each do |story|
        story.update_attribute(:title_ne, "<<NE>> " + story.title)
        story.update_attribute(:title_es, "<<ES>> " + story.title)
        story.update_attribute(:title_mx, "<<MX>> " + story.title)

        story.update_attribute(:body_ne, "<<NE>> " + story.body)
        story.update_attribute(:body_es, "<<ES>> " + story.body)
        story.update_attribute(:body_mx, "<<MX>> " + story.body)
      end
    end

    desc "Edit Neutral"
    task :storey_country_names_in_location_table => :environment do
      Location.all.each do |location|
        location.update_attribute(:country_name, location.country.name)
      end
    end


end