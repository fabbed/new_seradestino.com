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


  def track_registration
    if (visitor_session = get_visitor_session)
      visitor_session.user_id = @user.id
      visitor_session.save
      puts "registration tracked"
    else
      puts "error in trackpageview, has cookie but NO visitor_session"        
    end
  end

  def track_newsletter
      if (visitor_session = get_visitor_session)
        visitor_session.newsletter = true
        visitor_session.save
        puts "newsletter tracked"
      else
        puts "error in trackpageview, has cookie but NO visitor_session"        
      end
  end


  def track_avatar_upload
      if (visitor_session = get_visitor_session)
        visitor_session.avatar_uploaded = true
        visitor_session.save
        puts "avatar_uploaded_tracked"
      else
        puts "error in avatar uploaded"        
      end    
  end


  def track_avatar_clicked
      if (visitor_session = get_visitor_session)
        visitor_session.avatars_clicked << @user.id
        visitor_session.save
        puts "avatar_clicked_tracked"
      else
        puts "error in avatar clicked"        
      end    
  end

  def track_read_story
      if (visitor_session = get_visitor_session)
        visitor_session.stories_read << @story.id
        visitor_session.save
        puts "read_story_tracked"
      else
        puts "error in trackpageview, has cookie but NO visitor_session"        
      end
  end

  def track_rating
      if (visitor_session = get_visitor_session)
        visitor_session.ratings << @story.id
        visitor_session.save
        puts "read_story_tracked"
      else
        puts "error in trackpageview, has cookie but NO visitor_session"        
      end
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
