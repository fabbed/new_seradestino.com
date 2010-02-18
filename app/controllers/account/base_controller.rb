class Account::BaseController < ApplicationController
  before_filter :is_current_user?
  before_filter :activation_required, :except => [:activation_required]

  def show

  end
  
  def activation_required
    
  end
  
  protected
  
    def is_current_user?
      unless logged_in?
        
          visitor_session = VisitorSession.find_by_session_id(session[:visitor_session_id])
          if visitor_session
            v = Visitor.find(visitor_session.visitor.id)
            visitor_session.destroy
            v.destroy
          end

          session[:experiment] = false
          session[:visitor_session_id] = nil        
        
        redirect_to root_path
      end
    end
  
  
    def find_user
      @user = User.find(current_user)
    end

    def activation_required
      if current_user and !current_user.active?
        redirect_to :controller => "account/base", :action => "activation_required"
      end
    end
    
end
