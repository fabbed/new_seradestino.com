class StoriesController < LocatableController
  # GET /stories
  # GET /stories.xml

  protect_from_forgery :only => [:create, :update, :destroy] 
  before_filter :prepare_stuff, :only => [:vote_top, :vote_flop] 
  before_filter :load_story, :only => [:vote_top, :vote_flop, :rate] 
  before_filter :activation_required

  # def tag
  #   @stories = Story.find_tagged_with(params[:id], :match_all => true).paginate(:page => params[:page], :per_page => STORIES_PER_PAGE)
  #   @tags = Story.tag_counts    
  # end

  def load_story
    @story = Story.find(params[:id])    
    @rating = (params[:type] == "destino" ? 5 : 1)
    #todo: into I18N
    flash[:success] = "Has votado por la historia <a href='/stories/#{@story.id}'>#{@story.title}</a>. <br/>Gracias por el voto!"
  end
  
  def rate
    @story.rate_it(@rating.to_i, (current_user ? current_user.id : get_visitor_session.visitor.vcode))
    track_rating
    redirect_to root_path
  end

  def update_story_settings
    Story.update(params[:story].keys, params[:story].values)
    flash[:info] = 'Preferencias de tu historias guardadas'
    redirect_to my_account_path
  end


  def vote_top
    session[:top_votes] << @story.id

    @story.rated_top = @story.rated_top + 1
    @story.save

    new_rating

    respond_to do |wants|
      wants.html do
        redirect_to root_path
      end
      wants.js do
        render :partial => "mark_as_voted"
      end
    end
  end

  def vote_flop
    session[:flop_votes] << params[:id].to_i
    @story.rated_flop = @story.rated_flop + 1
    @story.save

    new_rating
    
    respond_to do |wants|
      wants.html do
        redirect_to root_path        
      end
      wants.js do
        render :partial => "mark_as_voted"
      end
    end
  end



  def new_rating
    #Track: New Comment
    #TODO TRACK
    # if (visitor_session = get_visitor_session)
    #   visitor_session.ratings << @story.id
    #   visitor_session.save
    #   puts "Track: New Rating"
    # else
    #   puts "error in track: new rating"        
    # end
  end

  def destino
    
    # date_range=case params[:tiempo]
    #   when nil
    #     (Date.today-30.days)..(Date.today)
    #   when "hoy"
    #     (Date.today-1.days)..Date.today
    #   when "ayer"
    #     (Date.today-2.days)..(Date.today-1.day)
    #   when "semana"
    #     (Date.today-7.days)..(Date.today)
    #   when "mes"
    #     (Date.today-30.days)..(Date.today)
    #   when "siempre"
    #     "no sort"
    # end
    # 
    # builder = Story.scope_builder
    # builder.tops
    # builder.date_between(date_range) unless date_range == "no sort"
    # builder.from_country(session[:selected_country]) if session[:selected_country]
    
    @stories = Story.all.sort_by{|t| - t.average_rating}.paginate(:page => params[:page], :per_page => 7)

  end

  def casualidad
    # date_range=case params[:tiempo]
    #   when nil
    #     (Date.today-30.days)..(Date.today)
    #   when "hoy"
    #     (Date.today-1.days)..Date.today
    #   when "ayer"
    #     (Date.today-2.days)..(Date.today-1.day)
    #   when "semana"
    #     (Date.today-7.days)..(Date.today)
    #   when "mes"
    #     (Date.today-30.days)..(Date.today)
    #   when "siempre"
    #     "no sort"
    # end
    # 
    # builder = Story.scope_builder
    # builder.flops
    # builder.date_between(date_range) unless date_range == "no sort"
    # builder.from_country(session[:selected_country]) if session[:selected_country]
    
    @stories = Story.all.sort_by(&:average_rating).paginate(:page => params[:page], :per_page => 7)
  end

  def index
    if !session[:experiment]
      builder = Story.scope_builder
      builder.newest_first
      builder.not_part_of_experiment
      @stories = builder.paginate(:page => params[:page], :per_page => 7)

    elsif session[:experiment] && get_visitor_session
      @stories = Story.find(get_visitor_session.stories_order)
    end

    # Add more stories to the existing 8
    if session[:experiment]
      #@stories = @stories.paginate(:page => params[:page], :per_page => 7)
      @stories = (@stories | Story.not_part_of_experiment.newest_first).paginate(:page => params[:page], :per_page => 7)
    end
    
    puts "Stories: #{@stories.size}"

  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    # story = Story.find(13)
    # story.location = session[:geo_location]
    # story.save

    @story = Story.find(params[:id])

    track_read_story

    @related_stories = Story.find_tagged_with(@story.tag_list, :limit => 10)
    @related_stories = @related_stories - [@story]
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        flash[:success] = '¡Muy bien!<br/> Ahora tu historia se encuentra en la página de inicio donde también puedes votar otras historias.'
        @story.tag_list = params[:story][:tag_list]
        @story.user = current_user if current_user

        track_story
        locate_story
        @story.save
        
        format.html { redirect_to root_path(:param => "historia_creado") }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])

    @story.tag_list = params[:story][:tag_list]
    @story.administered = true
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:info] = 'Story was successfully updated.'
        format.html { redirect_to admin_stories_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    flash[:info] = 'Story deleted.'    

    respond_to do |format|
      format.html { redirect_to(admin_stories_path) }
      format.xml  { head :ok }
    end
  end

  protected
    def activation_required
      if current_user and !current_user.activated_at
      flash[:info] = I18n.t('flash.thanks_for_signing_up', :email => current_user.email, :login => current_user.login)      end
    end



end
