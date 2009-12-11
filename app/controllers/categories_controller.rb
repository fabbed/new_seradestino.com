class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id].to_s)
    @stories = Story.from_category(@category.id).paginate(:page => params[:page], :per_page => STORIES_PER_PAGE)
  end

end


