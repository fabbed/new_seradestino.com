class Admin::ExperimentController < ApplicationController
  layout "admin_own"
  
  def index
    @visitor_sessions = []
    
    Visitor.all.each do |visitor|
      @visitor_sessions << visitor.visitor_sessions.first
    end
    
  end

end
