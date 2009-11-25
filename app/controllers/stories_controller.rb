class StoriesController < ApplicationController

  before_filter :find_story

  STORIES_PER_PAGE = 20

  def create
    @story = Story.new(params[:story])
    respond_to do |format|
      if @story.save
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to @story }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @story.destroy
        flash[:notice] = 'Story was successfully destroyed.'        
        format.html { redirect_to stories_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Story could not be destroyed.'
        format.html { redirect_to @story }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @stories = Story.paginate(:page => params[:page], :per_page => STORIES_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @stories }
    end
  end

  def edit
  end

  def new
    @story = Story.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @story }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @story }
    end
  end

  def update
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to @story }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_story
    @story = Story.find(params[:id]) if params[:id]
  end

end