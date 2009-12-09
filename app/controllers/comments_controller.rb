class CommentsController < LocatableController

  protect_from_forgery :except => [:create] 

  def create

    locate_comment
    
    unless params[:parent]
      @story = Story.find(params[:story])
      @comment = Comment.build_from(@story, current_user ? current_user.id : 0, params[:comment][:comment] )
      @comment.save
    else
      parent_comment = Comment.find(params[:parent])
      @story = Story.find(parent_comment.commentable_id)
     @comment = Comment.build_from(@story, current_user ? current_user.id : 0, params[:comment][:comment] )
     @comment.save
     @comment.move_to_child_of(parent_comment)
    end

    track_comment

    # if (@story.email.present? or @story.user_id > 0)
    #   UserMailer.deliver_new_comment(@story)
    # end

    flash[:success] = "Comentario enviado."
    
    respond_to do |wants|
        wants.html { redirect_to story_path(@story, :param => "comentario_creado", :anchor => "comment_#{@comment.id}") }
        wants.xml { render :xml => @comment, :status => :created, :location => @comment }
    end
  end
  
end
