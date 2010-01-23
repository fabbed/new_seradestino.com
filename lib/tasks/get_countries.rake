# rake stories:assign_comments
# rake stories:delete_doubles
# rake stories:find_long_words
# rake db:migrate
# rake stories:get_countries
# rake stories:get_real_country_names

# RAILS_ENV=production rake stories:assign_comments
# RAILS_ENV=production rake stories:delete_doubles
# RAILS_ENV=production rake stories:find_long_words
#RAILS_ENV=production stories:get_real_country_names
namespace :stories do

    desc "output countries"
    task :mark_good_ones => :environment do
      

      [1, 2, 3, 4, 5, 8, 10, 11, 21, 24, 46, 73, 81, 86, 98, 106, 110, 113, 118, 119, 121, 122, 137, 141, 142, 146, 147, 155, 157, 173, 177, 182, 186, 191].each do |id|
        Story.find(id).update_attribute(:fab_rating, 2)

    end
  end
end