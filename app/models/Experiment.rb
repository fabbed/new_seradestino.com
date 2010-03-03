class Experiment

  @@MAN_LEV = ["symbols", "dialect", "ugc"]
  @@APT_LEV = ["ne", "mx", "es"]
  @@APT_LEV_ALL = ["mx", "es"]

  def self.include_user_images?
    false
  end


  def self.get_layer(man_lev)
    man_lev.split("_")[0]
  end
    

  def self.dichotomize(amount, condition)
    return "TRUE" if amount > condition
    return "FALSE"
  end

  def self.time_on_page(session)
    
    if session.ajax_created_at && session.ajax_updated_at
      diff= session.ajax_updated_at - session.ajax_created_at
      if diff < 6000
        return (diff)
      else
        "NA"
      end
    elsif session.ajax_created_at && !session.ajax_updated_at
      return "NA"
    end
  
  end

  def self.adapted_lev(nationality, man_lev)
    if nationality == man_lev.split("_")[1]
      "TRUE"
    elsif man_lev.split("_")[1] == "ne"
      "NEUTRAL"
    else
      "FALSE"
    end
  end

  @@NEUTRAL_USERS = [280, 224, 46, 197, 128, 137, 147]


  def self.get_variation
      # unless rand(8) == 2

      unless 2 == 2
        @@MAN_LEV[rand(3)]+"_"+@@APT_LEV[rand(3)] + (self.include_user_images? ? "_with_avatars" : "_without_avatars")
      else
        "all"+"_"+@@APT_LEV_ALL[rand(2)] + (self.include_user_images? ? "_with_avatars" : "_without_avatars")
      end
  end

  def self.get_neutral_users
    User.find(@@NEUTRAL_USERS, :order => "rand()")
  end

  def self.get_experiment_avatars
    @@NEUTRAL_USERS.sort_by { rand }
  end

  def self.get_experiment_stories
    Story.find(:all, :conditions => {:experiment_story => true}, :order => "rand()", :limit => 8)
  end

  def self.getCSV(tiempo)

    date_range=case tiempo
      when nil
        (Date.today.beginning_of_day-1.days)..Date.today.end_of_day
      when "hoy"
        (Date.today.beginning_of_day)..Date.today.end_of_day
      when "ayer"
        (Date.today.beginning_of_day-1.days)..((Date.today-1.day).end_of_day)
      when "all"
        ((Date.today-4.month).end_of_day)..(Date.today.end_of_day)
    end

    puts "==================== EXPORT ========================"
    puts "Exporting: #{date_range}"

    FasterCSV.generate(:col_sep => "\t") do |csv|
      csv << ["nationality",
              "time_on_page", 
              "layer", 
              "adapted_to_nationality", 
              "avatar_pictures_shown", 
              "manipulation_lev", 
              "stories_read", 
              "stories_read_dichotomized", 
              "stories_rated",               
              "stories_rated_dichotomized", 
              "comments_written",              
              "comments_written_dichotomized",
              "stories_written",               
              "stories_written_dichotomized", 
              "avatars_clicked",              
              "avatars_clicked_dichotomized",
              "newsletter", 
              "registered", 
              "photo"
               ]

      
      sessions = Visitor.experiment_countries.date_between(date_range)
      puts "Total Sessions: #{VisitorSession.count}"      
      puts "Session from MX or ES: #{sessions.size}"
      sessions = sessions.map { |e| e.visitor_sessions.first }
      puts "Only first sessions: #{sessions.size}"
      sessions = sessions.reject { |e| e.ajax_on_load_time == NIL }
      puts "Sessions with onLoad: #{sessions.size}"
      
      sessions.each_with_index do |session, i|
          print "#{i}, "
          csv << [
            session.visitor.country_iso, 
            self.time_on_page(session),
            self.get_layer(session.visitor.manipulation_level),
            self.adapted_lev(session.visitor.country_iso.downcase, session.visitor.manipulation_level),
            session.visitor.manipulation_level.split("_").size == 4 ? "TRUE" : "FALSE",
            session.visitor.manipulation_level,

            session.stories_read.uniq.size, 
            dichotomize(session.stories_read.uniq.size, 0),

            session.ratings.uniq.size, 
            dichotomize(session.ratings.uniq.size, 0),

            session.comments.uniq.size, 
            dichotomize(session.comments.uniq.size, 0),

            session.stories.uniq.size,
            dichotomize(session.stories.uniq.size, 0),

            session.avatars_clicked.uniq.size,
            dichotomize(session.avatars_clicked.uniq.size, 0),
          
            session.newsletter ? "TRUE" : "FALSE", 
            session.user_id ? "TRUE" : "FALSE", 
            session.avatar_uploaded == false ? "FALSE" : "TRUE"]

      end
    end
  end



end
