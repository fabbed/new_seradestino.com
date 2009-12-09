class Account::BaseController < ApplicationController
  before_filter :login_required
  before_filter :activation_required, :except => [:activation_required]

  def show

  end
  
  def activation_required
    
  end
  
  protected
  
    def find_user
      @user = User.find(current_user)
    end

    def activation_required
      if current_user and !current_user.active?
        redirect_to :controller => "account/base", :action => "activation_required"
      end
    end
    
end
