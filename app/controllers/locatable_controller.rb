class LocatableController < ApplicationController

  def locate_comment

    location = session[:geo_location]
    if location
      comment.ip = request.env["REMOTE_ADDR"]
      comment.country_id = Country.find_by_iso(location.country_code.upcase).used_id if location.country_code
    end

  end


  def locate_story
    location = session[:geo_location]
    if location
      @story.ip = request.env["REMOTE_ADDR"]
      @story.lat = location.lat if location.lat
      @story.lng = location.lng if location.lng
      @story.city = location.city if location.city
      @story.country_code = location.country_code if location.country_code
      @story.country_id = Country.find_by_iso(location.country_code.upcase).used_id if location.country_code
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
