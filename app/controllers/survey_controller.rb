class SurveyController < ApplicationController
  
  
  def create
    if (visitor_session = get_visitor_session)
      visitor = visitor_session.visitor
      
      if params[:survey_id] == "survey_country"
        if Country.find(params[:survey_result])
          visitor.survey_country = Country.find(params[:survey_result]).iso
        else
          visitor.survey_country = "no selection"
        end
      elsif params[:survey_id] == "survey_gender"
        visitor.survey_gender = params[:survey_result]
      elsif params[:survey_id] == "survey_page_origin"
        visitor.survey_nationality_of_page = params[:survey_result]
      end
      
      visitor.save
      puts "survey saved"
    else
      puts "error in country survey"        
    end
    flash[:success] = "¡Gracias por tu respuesta!"
    redirect_to root_path
  end
  
  
end
