class Visitor < ActiveRecord::Base
  
  has_many :visitor_sessions, :dependent => :destroy
  belongs_to :country


  named_scope :date_between, lambda { |date_range|   { :conditions => { :created_at => date_range } } }
  named_scope :experiment_countries, :conditions => ['country_iso = ? OR country_iso = ?', "ES", "MX"]
  




  def create_visitor_session(request)
    self.visitor_sessions << VisitorSession.create(
                                            :session_id => request.session.session_id, 
                                            :ip => request.env["REMOTE_ADDR"],
                                            :request_method => request.env["REQUEST_METHOD"],
                                            :referer => request.env["HTTP_REFERER"],
                                            :http_accept_language => request.env["HTTP_ACCEPT_LANGUAGE"],
                                            :user_agent => request.env["HTTP_USER_AGENT"],
                                            :comments => Array.new,                                            
                                            :stories => Array.new,                                            
                                            :recommendations => Array.new,                                            
                                            :ratings => Array.new,
                                            :stories_read => Array.new,
                                            :stories_order => Experiment.get_experiment_stories.map(&:id),
                                            :avatars_order => Experiment.get_experiment_avatars,
                                            :avatars_clicked => Array.new

                                            )
  end



  def first_session_pageviews
    self.visitor_sessions.first.pageviews
  end

  def first_session_time_on_page
    self.visitor_sessions.first.updated_at - self.visitor_sessions.first.created_at
  end

  def first_session_comments
    self.visitor_sessions.first.comments
  end

  def first_session_stories
    self.visitor_sessions.first.stories
  end

  def first_session_ratings
    self.visitor_sessions.first.ratings
  end




  def self.create_new(request, location, manipulation)
    new_visitor = self.new
    new_visitor.vcode = self.generate_vcode
    new_visitor.referer = request.env["HTTP_REFERER"]
    new_visitor.ip = request.env["REMOTE_ADDR"]
    
    if location
      new_visitor.country_id = Country.find_by_iso(location.country_code.upcase).used_id if location.country_code
    end

    new_visitor.manipulation_level = manipulation
    new_visitor.user_agent = request.env["HTTP_USER_AGENT"]
    new_visitor.save!
    new_visitor
  end


  def self.generate_vcode
    return rand(36**8).to_s(36)
  end


end
