namespace :exp do

    desc "Survey Results"
    task :get_survey_results => :environment do
      
      count_survey_gender = Visitor.find(:all, 
        :conditions => ['survey_identifier = ? 
                         AND (country_iso = ? OR country_iso = ?)', "survey_gender", "MX", "ES"])

      count_survey_country = Visitor.find(:all, 
        :conditions => ['survey_identifier = ? 
                         AND (country_iso = ? OR country_iso = ?)', "survey_country", "MX", "ES"])
      
      
      count_survey_gender_not_null = Visitor.find(:all, 
        :conditions => ['survey_identifier = ? 
                         AND survey_gender IS NOT NULL 
                         AND (country_iso = ? 
                         OR country_iso = ?)', 
                         "survey_gender", "MX", "ES"])

      count_survey_country_not_null = Visitor.find(:all, 
        :conditions => ['survey_identifier = ? 
                         AND (country_iso = ? OR country_iso = ?)
                         AND survey_country IS NOT NULL', "survey_country", "ES", "MX"])

    
                         
      puts "####### GENDER SURVEY ###########"
      puts "Gender Survey shown: #{count_survey_gender.size}"
      puts "Gender Survey responded: #{count_survey_gender_not_null.size}"      
      puts "Count female: #{count_survey_gender_not_null.select { |e| e.survey_gender == "f" }.size}"      
      puts "Count male: #{count_survey_gender_not_null.select { |e| e.survey_gender == "m" }.size}"      
      puts "Count female ES: #{count_survey_gender_not_null.select { |e| e.survey_gender == "f" && e.country_iso == "ES" }.size}"
      puts "Count male ES: #{count_survey_gender_not_null.select { |e| e.survey_gender == "m" && e.country_iso == "ES" }.size}"
      puts "Count female MX: #{count_survey_gender_not_null.select { |e| e.survey_gender == "f" && e.country_iso == "MX" }.size}"
      puts "Count male MX: #{count_survey_gender_not_null.select { |e| e.survey_gender == "m" && e.country_iso == "MX" }.size}"
      puts "####### Registered Users ###########"
      visitors_who_became_users = VisitorSession.find(
        :all, 
        :conditions => ['user_id > 0']).uniq
      
      puts "ES users female: #{visitors_who_became_users.select { |e| e.visitor.country_iso == "ES" and e.user.gender == "f" }.size}"
      
      puts "ES users male: #{visitors_who_became_users.select { |e| e.visitor.country_iso == "ES" and e.user.gender == "m" }.size}"
      
      puts "MX users female: #{visitors_who_became_users.select { |e| e.visitor.country_iso == "MX" and e.user.gender == "f" }.size}"
      
      puts "MX users male: #{visitors_who_became_users.select { |e| e.visitor.country_iso == "MX" and e.user.gender == "m" }.size}"


      puts "####### GENDER Country ###########"
      puts "Gender country shown: #{count_survey_country.size}"      
      puts "Gender country responded: #{count_survey_country_not_null.size}"
      
      equal = 0
      non_equal = 0
      
      puts
      count_survey_country_not_null.each do |visitor|
        if visitor.country_iso == visitor.survey_country
          equal = equal + 1
        else
          non_equal = non_equal + 1
        end
        # puts "#{visitor.country_iso}-#{visitor.survey_country}"
      end
        puts "Equal: #{equal} | Non-Equal #{non_equal}"      
    end



    desc "Remove Tag"
    task :get_csv => :environment do
      csv_string = Experiment.getCSV("all")  
      puts "Wrting File"
      File.open("./public/experiment/pure_results.txt", 'w') {|f| f.write(csv_string) }            
    end

    desc "Remove Tag"
    task :get_cont_table => :environment do
      csv_string = Experiment.getContTable()  
      puts "Wrting File"
      File.open("./public/experiment/cont_results.txt", 'w') {|f| f.write(csv_string) }            
    end

    desc "Remove Tag"
    task :get_dummy => :environment do
      csv_string = Experiment.getDummyTable(ENV['variable'])  
      puts "Wrting File"
      File.open("./public/experiment/#{ENV['variable']}_dummy_coded_numeric.txt", 'w') {|f| f.write(csv_string) }            
    end
  
    desc "Remove Tag"
    task :comments => :environment do
    end

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


# Visitor.find_all_by_country_iso("0").size
# 
# Visitor.find_all_by_country_iso("0").each do |visitor|
#   visitor.country_iso = "0"
#   visitor.save
# end
# 
# Visitor.find_all_by_country_iso("0").size

	  Geokit::Geocoders::google = 'ABQIAAAAkzCpk0J1FPlWiSinzJS-6hQasU70E895awct6WnEz2cX57FcExR-8TDVSJXcZAB8ZToBgaBanLSjRw'

      Visitor.all.each do |story|

        if false
          location = GeoKit::Geocoders::GeoPluginGeocoder.geocode("189.152.195.113")
          puts location.to_yaml
        else

          if !story.ip
            puts "Visitor #{story.id} has no IP"
            story.country_iso = "xx"
            story.save
          elsif story.ip and (story.country_iso == "0" or !story.country_iso or story.country_iso == "NA")
            # location = GeoKit::Geocoders::IpGeocoder.geocode(story.ip)
            location = Geokit::Geocoders::MultiGeocoder.geocode("#{story.ip}")
            if location.success
              puts location.country_code
              story.country_iso = location.country_code
              story.save
            else
              puts "NA"
              story.country_id = nil
              story.country_iso = "NA"
              story.save
            end
          end
        end
      end
    end
    
    




end