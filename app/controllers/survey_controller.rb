class SurveyController < ApplicationController
  
  
  def create
    if (visitor_session = get_visitor_session)
      visitor = visitor_session.visitor
      
      if params[:survey_id] == "survey_country"
        visitor.survey_country = Country.find(params[:survey_result]).iso
      elsif params[:survey_id] == "survey_gender"
        visitor.survey_gender = params[:survey_result]
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
