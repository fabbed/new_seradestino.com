class Experiment

  @@MAN_LEV = ["symbols", "dialect", "ugc"]
  @@APT_LEV = ["ne", "mx", "es"]

  @@NEUTRAL_USERS = [280, 224, 46, 197, 128, 137, 147]


  def self.get_variation
      @@MAN_LEV[rand(3)]+"_"+@@APT_LEV[rand(3)]
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

    FasterCSV.generate(:col_sep => "\t") do |csv|
      csv << ["session_id", "nationality", "manipulation_level", "ip", "pageviews", "stories_read", "stories_rated", "newsletter", "comments written", "registered", "photo", "stories_written", "avatars_clicked"]

      sessions = Visitor.experiment_countries.date_between(date_range).map { |e| e.visitor_sessions.first }
      sessions.reject { |e| e.ajax_on_load_time == NIL }.each do |session|
        csv << [session.id, session.visitor.country_iso, session.visitor.manipulation_level, session.ip, session.pageviews, session.stories_read.uniq.size, session.ratings.uniq, session.newsletter ? "yes" : "no", session.comments, session.user_id ? "yes" : "no", session.avatar_uploaded == false ? "no" : "yes", session.stories, session.avatars_clicked.uniq.size]
      end
    end
  end



end
