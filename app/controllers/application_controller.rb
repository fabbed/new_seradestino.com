# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < TrackingController
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  
  geocode_ip_address if RAILS_ENV == "production"
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  STORIES_PER_PAGE = 6

  before_filter :create_visitor_or_load_existing



  private

    def get_visitor_session
      if has_cookie? and has_session?
        visitor_session = VisitorSession.find_by_session_id(session[:visitor_session_id])
        if visitor_session
            return visitor_session if visitor_session.visitor_id == session[:visitor_id]
        else
          return false
        end
      end
      return false
    end

    
    def create_visitor_or_load_existing
      puts "============================================================="
      puts "============create_visitor_or_load_existing=================="
      if !(robot?(request.user_agent)) and request.env["REQUEST_METHOD"] == "GET" #if no robot
        if referrer?(request.env["HTTP_REFERER"]) and !(has_cookie?) and !(has_session?) and params[:controller] == "stories" and params[:action] == "index" #kein cookie & STARTSEITE
          #TODO: Nur wenn referer
          session[:experiment] = true
          puts "==== -> New first visitor"
          man_level = Experiment.get_variation
          puts "Randomizing manipulation_level and adaption_level: #{man_level}"
          new_visitor = Visitor.create_new(request, session[:geo_location], man_level)
          new_visitor.create_visitor_session(request)
          store_session_variables(new_visitor.id, new_visitor.visitor_sessions.last.session_id)
          cookies[:vcode] = { :value => new_visitor.vcode, :expires => Time.now.next_year}
        elsif (!has_cookie? and (has_session?)) #wenn er ne session hat aber kein cookie -> cookies disabled
          visitor_session = VisitorSession.find_by_session_id(session[:visitor_session_id])
          v = visitor_session.visitor
          visitor_session.destroy
          v.destroy
          session[:experiment] = false
          session[:visitor_session_id] = nil
        elsif (has_cookie? and !(has_session?)) #wenn er cookie hat aber keine session
          session[:experiment] = false
          puts "==== -> Returning visitor"
          if (returning_visitor = Visitor.find_by_vcode(cookies[:vcode])) #visitor laden
            returning_visitor.logins = returning_visitor.logins + 1
            returning_visitor.create_visitor_session(request) #neue session
            returning_visitor.save
            store_session_variables(returning_visitor.id, returning_visitor.visitor_sessions.last.session_id)
          end
        elsif (has_cookie? and has_session?) 
          puts "==== -> Session continuation"
          if ((visitor_session = get_visitor_session))
            visitor_session.pageviews = visitor_session.pageviews + 1
            visitor_session.save
            puts "pageview + 1"
          end
        end
      end
      puts "============================================================="
    end

    def store_session_variables(visitor_id, last_session_id)
      session[:visitor_id] = visitor_id
      session[:visitor_session_id] = last_session_id
    end

    def has_session?
      if session[:visitor_id]
        return true
      else
        return false
      end
      
    end

    def has_cookie?
      unless cookies[:vcode]
        return false
      else
        return true
      end
    end

    def robot?(user_agent)
      user_agent =~ /(Baidu|bot|Google|SiteUptime|Slurp|WordPress|ZIBB|ZyBorg|Spider|Sogou)/i
    end

    def referrer?(referrer)
      return true if RAILS_ENV == "development"
      referrer =~ /(trucos-de-belleza|xalut|conocer)/i      
    end
    


  
end
