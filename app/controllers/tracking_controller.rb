class TrackingController < ActionController::Base


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
  




end
