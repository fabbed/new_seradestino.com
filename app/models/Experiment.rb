class Experiment

  @@MAN_LEV = ["symbols", "dialect", "ugc"]
  @@APT_LEV = ["ne", "mx", "es"]

  @@NEUTRAL_USERS = [280, 224, 46, 197, 128, 137, 147]


  def self.get_variation
      @@MAN_LEV[rand(3)]+"_"+@@APT_LEV[rand(3)]
      "ugc_ne"
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


end
