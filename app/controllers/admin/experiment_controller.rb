class Admin::ExperimentController < ApplicationController
  layout "admin_own"
  
  def index
    @visitor_sessions = []

    @test_today =  Date.today(params[:today])

    @today = Date.today
    @yesterday = Date.today - 2.days
    
    date_range=case params[:tiempo]
      when nil
        (Date.today.beginning_of_day-1.days)..Date.today.end_of_day
      when "hoy"
        (Date.today.beginning_of_day)..Date.today.end_of_day
      when "ayer"
        (Date.today.beginning_of_day-1.days)..((Date.today-1.day).end_of_day)
      when "all"
        (Date.today-1.month)..(Date.today.end_of_day)
    end
    
    @visitor_sessions = Visitor.date_between(date_range).map { |e| e.visitor_sessions.first }
    
  end


  def download

    csv_string = Experiment.getCSV(params[:tiempo])


    send_data(csv_string,
             :type => 'text/csv; charset=UTF-8; header=present',
             :disposition => "attachment; filename=sd_exp_results.txt")

    end

end
