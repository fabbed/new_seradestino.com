class LocatableController < ApplicationController

  def locate_comment
    @comment.location = Location.build(@comment, session[:geo_location], request.env["REMOTE_ADDR"]) if session[:geo_location]
  end

  def locate_story
    @story.location = Location.build(@story, session[:geo_location], request.env["REMOTE_ADDR"]) if session[:geo_location]
  end

  def locate_user
    @user.location = Location.build(@user, session[:geo_location], request.env["REMOTE_ADDR"]) if session[:geo_location]
  end

  def track_story
      if (visitor_session = get_visitor_session)
        visitor_session.stories << @story.id
        visitor_session.save
        puts "story_tracked"
      else
        puts "error in trackpageview, has cookie but NO visitor_session"        
      end
  end


  def track_comment
    if (visitor_session = get_visitor_session)
      visitor_session.comments << @comment.id
      visitor_session.save
      puts "Track: New Comments"
    else
      puts "error in track: new comment"        
    end
    
  end

end
