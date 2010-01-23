class Account::AvatarsController < LocatableController
  before_filter :find_user
  
  def show
    track_newsletter
  end
  
  def update

    if @user.update_attributes(params[:user])
      flash[:info] = I18n.t('account.avatar_updated')
      track_avatar_upload
      redirect_to my_account_path
    else
      render :action => "show"
    end
    
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
