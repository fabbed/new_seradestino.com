namespace :exp do


    desc "Remove Tag"
    task :get_exp_stories => :environment do
      Story.find(:all, :conditions => ['fab_rating = ?', 3]).each do |story|
        puts "================================================================="
        puts "Origen del autor: " + story.location.country_name
        puts "Titulo Original: " + story.title
        puts "____________"        
        puts "Body Original: "
        puts story.body
        puts
        puts "====== Neutral ======="
        puts "Titulo: "
        puts "____________"        
        puts "Body: "
        puts
        puts "====== ES ======="
        puts "Titulo: "
        puts "____________"        
        puts "Body: "
        puts
        puts "====== MX ======="
        puts "Titulo: "
        puts "____________"        
        puts "Body: "
        puts
        
      end
      false
    end


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



    desc "Migrates DB to Version=0 imports geodata and universities, clones db to test_db, imports data for test_db"
    task :get_countries_for_visitors => :environment do

      require 'geokit'

	  Geokit::Geocoders::google = 'ABQIAAAAkzCpk0J1FPlWiSinzJS-6hQasU70E895awct6WnEz2cX57FcExR-8TDVSJXcZAB8ZToBgaBanLSjRw'

      Visitor.all.each do |story|

        if false
          location = GeoKit::Geocoders::GeoPluginGeocoder.geocode("189.152.195.113")
          puts location.to_yaml
        else

          if !story.ip
            story.country_code = "xx"
            story.save
          elsif story.ip
            # location = GeoKit::Geocoders::IpGeocoder.geocode(story.ip)
            location = GeoKit::Geocoders::GeoPluginGeocoder.geocode("#{story.ip}")    
            if location.success
              puts location.country_code
              story.country_iso = location.country_code
              story.save
            else
              story.country_id = nil
              story.country_iso = "xx"
              story.save
            end
          end
        end
      end
    end
    
    




end