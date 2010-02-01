class AjaxTrackingController < TrackingController


  def time_on_page
    if (visitor_session = get_visitor_session)

      if visitor_session.ajax_created_at.nil?
        VisitorSession.update_all({:ajax_created_at => Time.now}, {:id => visitor_session.id})
      else
        VisitorSession.update_all({:ajax_updated_at => Time.now}, {:id => visitor_session.id})      
      end

      visitor_session.save
      render :text => "OK", :layout => false
    else
      render :text => "ERROR", :layout => false
    end

  end



  def time_on_page_on_load
    if (visitor_session = get_visitor_session)

      if visitor_session.ajax_on_load_time.nil?
        VisitorSession.update_all({:ajax_on_load_time => Time.now}, {:id => visitor_session.id})
      end
      visitor_session.save
      render :text => "OK", :layout => false
    else
      render :text => "ERROR", :layout => false
    end

  end


end
