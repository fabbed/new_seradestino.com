class Experiment

  @@MAN_LEV = ["symbols", "dialect", "ugc"]
  @@APT_LEV = ["ne", "mx", "es"]
  @@APT_LEV_ALL = ["mx", "es"]


  def self.get_values_for_dummy(nationality, level, adaptation, which, var)
    nationality = 
      case nationality
      when "mexican"
        "mx"
      when "spanish"
        "es"
      end
      
    adaptation = 
      case adaptation
      when "neutral"
        "ne"
      when "es"
        "es"
      when "mx"
        "mx"
      end      

    level_changed = level+"_"+adaptation

    puts "#{nationality}, #{adaptation}, #{level_changed}"

    freq_no       = 0
    freq_yes      = 0

    puts "Before SQL"
        
    visitors = Visitor.find(:all, :joins => :visitor_sessions, :conditions => 
      ["(manipulation_level = ? or manipulation_level = ?) AND 
        visitor_sessions.ajax_on_load_time IS NOT NULL AND
        country_iso = ?", level_changed, level_changed+"_without_avatars",nationality])
    
    puts "After SQL"
    puts visitors.size
    
    puts "Before map"
    sessions = visitors.map { |e| e.visitor_sessions.first }
    puts "After map"

    puts "Sessions: #{sessions.size}"        
    sessions.each do |session|

      if var == "stories_read" or var == "comments" or var == "stories" or var == "ratings"
        freq_no     =         (freq_no          + 1) if eval("session.#{var}.size") == 0
        freq_yes    =         (freq_yes         + 1) if eval("session.#{var}.size")  > 0
      elsif var == "newsletter"
        freq_no     =         (freq_no          + 1) if eval("session.#{var}") == false
        freq_yes    =         (freq_yes         + 1) if eval("session.#{var}") == true
      elsif var == "registered"
        freq_no     =         (freq_no          + 1) if !session.user_id
        freq_yes    =         (freq_yes         + 1) if session.user_id
      end

    end
    
    puts "Nationality transform"
    dummy_nationality = 
      case nationality
      when "mx"
        "0"
      when "es"
        "1"
      end
    
    dummy_level = 
      case level
      when "symbols"
        "0"
      when "dialect"
        "1"
      when "ugc"
        "2"
      when "all"
        "3"
      end     
    
    dummy_adaptation = 
      case adaptation
      when "ne"
        "1"
      when "es"
        "0"
      when "mx"
        "2"
      end      
    
    dummy_which =
      case which
      when "yes"
        "1"
      when "no"
        "0"
      end      
    
    puts "Before return"

    if    which == "yes"
      return [dummy_nationality, dummy_level, dummy_adaptation, dummy_which, freq_yes]
    elsif which == "no"
      return [dummy_nationality, dummy_level, dummy_adaptation, dummy_which, freq_no]      
    end
        
  end

  def self.getDummyTable(var)

    puts "Start"
  
    FasterCSV.generate(:col_sep => "\t") do |csv|
      csv << ["nationality",
              "level", 
              "adaptation",
              "story_read",
              "frequency", 
               ]

   puts "Mexican Symbols"
    
    csv << get_values_for_dummy("mexican", "symbols", "es", "yes", var)
    
    puts "next"
    csv << get_values_for_dummy("mexican", "symbols", "es", "no", var)
    csv << get_values_for_dummy("mexican", "symbols", "neutral", "yes", var)
    csv << get_values_for_dummy("mexican", "symbols", "neutral", "no", var)
    csv << get_values_for_dummy("mexican", "symbols", "mx", "yes", var)
    csv << get_values_for_dummy("mexican", "symbols", "mx", "no", var)

   puts "Mexican Dialects"

    csv << get_values_for_dummy("mexican", "dialect", "es", "yes", var)
    csv << get_values_for_dummy("mexican", "dialect", "es", "no", var)
    csv << get_values_for_dummy("mexican", "dialect", "neutral", "yes", var)
    csv << get_values_for_dummy("mexican", "dialect", "neutral", "no", var)    
    csv << get_values_for_dummy("mexican", "dialect", "mx", "yes", var)
    csv << get_values_for_dummy("mexican", "dialect", "mx", "no", var)

    puts "Mexican ugc"

    csv << get_values_for_dummy("mexican", "ugc", "es"     , "yes", var)
    csv << get_values_for_dummy("mexican", "ugc", "es"     , "no", var)
    csv << get_values_for_dummy("mexican", "ugc", "neutral", "yes", var)
    csv << get_values_for_dummy("mexican", "ugc", "neutral", "no", var)
    csv << get_values_for_dummy("mexican", "ugc", "mx"     , "yes", var)  
    csv << get_values_for_dummy("mexican", "ugc", "mx"     , "no", var)      
    
    mx_symbols_ne_yes = get_values_for_dummy("mexican", "symbols", "neutral", "yes", var)
    mx_symbols_ne_no  = get_values_for_dummy("mexican", "symbols", "neutral", "no" , var)    
        
    mx_symbols_ne_yes[0] = "0"
    mx_symbols_ne_yes[1] = "3"
    mx_symbols_ne_yes[2] = "1"
    mx_symbols_ne_no[0] = "0"
    mx_symbols_ne_no[1] = "3"
    mx_symbols_ne_no[2] = "1"

    csv << get_values_for_dummy("mexican", "all", "es", "yes", var)
    csv << get_values_for_dummy("mexican", "all", "es", "no", var)    
    csv << mx_symbols_ne_yes
    csv << mx_symbols_ne_no    
    csv << get_values_for_dummy("mexican", "all", "mx", "yes", var)
    csv << get_values_for_dummy("mexican", "all", "mx", "no", var)    



    # SPANIARDS

   puts "Spanish Symbols"
    
    csv << get_values_for_dummy("spanish", "symbols", "es", "yes", var)
    csv << get_values_for_dummy("spanish", "symbols", "es", "no", var)
    csv << get_values_for_dummy("spanish", "symbols", "neutral", "yes", var)
    csv << get_values_for_dummy("spanish", "symbols", "neutral", "no", var)
    csv << get_values_for_dummy("spanish", "symbols", "mx", "yes", var)
    csv << get_values_for_dummy("spanish", "symbols", "mx", "no", var)
    
    
   puts "Spanish Dialect"    
    csv << get_values_for_dummy("spanish", "dialect", "es", "yes", var)
    csv << get_values_for_dummy("spanish", "dialect", "es", "no", var)
    csv << get_values_for_dummy("spanish", "dialect", "neutral", "yes", var)
    csv << get_values_for_dummy("spanish", "dialect", "neutral", "no", var)    
    csv << get_values_for_dummy("spanish", "dialect", "mx", "yes", var)
    csv << get_values_for_dummy("spanish", "dialect", "mx", "no", var)

   puts "Spanish UGC"

    csv << get_values_for_dummy("spanish", "ugc", "es"     , "yes", var)
    csv << get_values_for_dummy("spanish", "ugc", "es"     , "no", var)
    csv << get_values_for_dummy("spanish", "ugc", "neutral", "yes", var)
    csv << get_values_for_dummy("spanish", "ugc", "neutral", "no", var)
    csv << get_values_for_dummy("spanish", "ugc", "mx"     , "yes", var)  
    csv << get_values_for_dummy("spanish", "ugc", "mx"     , "no", var)      
    
    es_symbols_ne_yes = get_values_for_dummy("spanish", "symbols", "neutral", "yes", var)
    es_symbols_ne_no  = get_values_for_dummy("spanish", "symbols", "neutral", "no" , var)    
        
    es_symbols_ne_yes[0] = "1"
    es_symbols_ne_yes[1] = "3"
    es_symbols_ne_yes[2] = "1"
    es_symbols_ne_no[0] = "1"
    es_symbols_ne_no[1] = "3"
    es_symbols_ne_no[2] = "1"

    csv << get_values_for_dummy("spanish", "all", "mx", "yes", var)
    csv << get_values_for_dummy("spanish", "all", "mx", "no", var)    
    csv << es_symbols_ne_yes
    csv << es_symbols_ne_no    
    csv << get_values_for_dummy("spanish", "all", "es", "yes", var)
    csv << get_values_for_dummy("spanish", "all", "es", "no", var)  

    csv
             
   end    
    
  end



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

      unless rand(8) == 2
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

  
  def self.get_values_for(nationality, level, adaptation)
    print "."
    nationality = 
      case nationality
      when "mexican"
        "mx"
      when "spanish"
        "es"
      end
      
    adaptation = 
      case adaptation
      when "neutral"
        "ne"
      when "es"
        "es"
      when "mx"
        "mx"
      end      
    
    level_changed = level+"_"+adaptation

    story_read_no       = 0
    story_read_yes      = 0
    story_rated_no      = 0
    story_rated_yes     = 0
    newsletter_no       = 0
    newsletter_yes      = 0
    registered_no       = 0
    registered_yes      = 0
    story_written_no    = 0
    story_written_yes   = 0
    story_commented_no  = 0
    story_commented_yes = 0
    
    visitors = Visitor.find(:all, :joins => :visitor_sessions, :conditions => 
      ["(manipulation_level = ? or manipulation_level = ?) AND 
        visitor_sessions.ajax_on_load_time IS NOT NULL AND
        country_iso = ?", level_changed, level_changed+"_without_avatars",nationality])
    
    sessions = visitors.map { |e| e.visitor_sessions.first }
    
    sessions.each do |session|
      story_read_no     =         (story_read_no          + 1) if session.stories_read.size == 0
      story_read_yes    =         (story_read_yes         + 1) if session.stories_read.size > 0
      story_rated_no    =         (story_rated_no         + 1) if session.ratings.size == 0
      story_rated_yes   =         (story_rated_yes        + 1) if session.ratings.size > 0
      newsletter_no     =         (newsletter_no          + 1) if !session.newsletter
      newsletter_yes    =         (newsletter_yes         + 1) if session.newsletter
      registered_no     =         (registered_no          + 1) if !session.user_id
      registered_yes      =       (registered_yes         + 1) if session.user_id 
      story_written_no    =       (story_written_no       + 1) if session.stories.size == 0
      story_written_yes   =       (story_written_yes      + 1) if session.stories.size > 0
      story_commented_no  =       (story_commented_no     + 1) if session.comments.size == 0
      story_commented_yes =       (story_commented_yes    + 1) if session.comments.size > 0
    end

    
    level_and_adaptation = level+"_"+adaptation
    
    if adaptation ==  nationality
      adapted = "TRUE"
    elsif adaptation ==  "ne"
      adapted = "NEUTRAL"
    elsif adaptation !=  nationality
      adapted = "FALSE"
    end

    nationality_and_adaptation        = nationality + "_" + level
    nationality_level_and_adaptation  = nationality + "_" + level_changed
    
    return [nationality, level, adaptation, level_and_adaptation, nationality_and_adaptation, nationality_level_and_adaptation, adapted, story_read_no,story_read_yes,story_rated_no,story_rated_yes,newsletter_no,newsletter_yes,registered_no,registered_yes,story_written_no,story_written_yes,story_commented_no,story_commented_yes]
        
  end


  def self.getContTable
  
    FasterCSV.generate(:col_sep => "\t") do |csv|
      csv << ["nationality",
              "level", 
              "adaptation", 
              "level_and_adaptation",               
              "nationality_and_adaptation",
              "nationality_level_and_adaptation",
              "adapted",                             
              "story_read_no", 
              "story_read_yes", 
              "story_rated_no", 
              "story_rated_yes", 
              "newsletter_no", 
              "newsletter_yes",              
              "registered_no",
              "registered_yes",               
              "story_written_no", 
              "story_written_yes",              
              "story_commented_no", 
              "story_commented_yes"
               ]
    
    csv << get_values_for("mexican", "symbols", "es")
    csv << get_values_for("mexican", "symbols", "neutral")
    csv << get_values_for("mexican", "symbols", "mx")

    csv << get_values_for("mexican", "dialect", "es")
    csv << get_values_for("mexican", "dialect", "neutral")
    csv << get_values_for("mexican", "dialect", "mx")

    csv << get_values_for("mexican", "ugc", "es")
    csv << get_values_for("mexican", "ugc", "neutral")
    csv << get_values_for("mexican", "ugc", "mx")

    mx_symbols_ne = get_values_for("mexican", "symbols", "neutral")
    mx_symbols_ne[0] = "mx"
    mx_symbols_ne[1] = "all"
    mx_symbols_ne[2] = "ne"
    mx_symbols_ne[3] = "all_ne"
    mx_symbols_ne[4] = "mx_all"
    mx_symbols_ne[5] = "mx_all_ne"
    mx_symbols_ne[6] = "NEUTRAL"

    csv << get_values_for("mexican", "all", "es")
    csv << mx_symbols_ne
    csv << get_values_for("mexican", "all", "mx")

    csv << get_values_for("spanish", "symbols", "mx")
    csv << get_values_for("spanish", "symbols", "neutral")
    csv << get_values_for("spanish", "symbols", "es")
    
    csv << get_values_for("spanish", "dialect", "mx")
    csv << get_values_for("spanish", "dialect", "neutral")
    csv << get_values_for("spanish", "dialect", "es")

    csv << get_values_for("spanish", "ugc", "mx")
    csv << get_values_for("spanish", "ugc", "neutral")
    csv << get_values_for("spanish", "ugc", "es")

    es_symbols_ne = get_values_for("spanish", "symbols", "neutral")
    es_symbols_ne[0] = "es"
    es_symbols_ne[1] = "all"
    es_symbols_ne[2] = "ne"
    es_symbols_ne[3] = "all_ne"
    es_symbols_ne[4] = "es_all"
    es_symbols_ne[5] = "es_all_ne"
    es_symbols_ne[6] = "NEUTRAL"

    
    csv << get_values_for("spanish", "all", "mx")
    csv << es_symbols_ne
    csv << get_values_for("spanish", "all", "es")              
   end    
    
    
    
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
