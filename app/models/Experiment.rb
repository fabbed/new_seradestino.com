class Experiment

  @@MAN_LEV = ["symbols", "dialect", "ugc"]
  @@APT_LEV = ["ne", "mx", "es"]

  @@MX_USERS = [66,49,43, 18, 10, 11]
  @@ES_USERS = [1]


  def self.get_variation
      @@MAN_LEV[rand(3)]+"_"+@@APT_LEV[rand(3)]
  end

  def self.get_mexican_users
    User.find(@@MX_USERS, :order => "rand()")
  end

  def self.get_spanish_users
    User.find(@@ES_USERS, :order => "rand()")
  end

  def self.get_experiment_stories
    Story.find(:all, :conditions => {:experiment_story => true}, :order => "rand()", :limit => 3)
  end


end
