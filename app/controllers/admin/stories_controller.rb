# Controller generated by Typus, use it to extend admin functionality.
class Admin::StoriesController < Admin::MasterController


  ##
  # You can overwrite and extend Admin::MasterController with your methods.
  #
  # Actions have to be defined in <tt>config/typus/application.yml</tt>:
  #
  #   Story:
  #     actions:
  #       index: custom_action
  #       edit: custom_action_for_an_item
  #
  # And you have to add permissions on <tt>config/typus/application_roles.yml</tt> 
  # to have access to them.
  #
  #   admin:
  #     Story: create, read, update, destroy, custom_action
  #
  #   editor:
  #     Story: create, read, update, custom_action_for_an_item
  #

  # def index
  # 
  # 
  # 
  #   @conditions, @joins = @resource[:class].build_conditions(params)
  #   @conditions = "(`stories`.`experiment_story` = 1)"
  #   check_ownership_of_items if @resource[:class].typus_options_for(:only_user_items)
  # 
  #   respond_to do |format|
  #     format.html { generate_html }
  #     @resource[:class].typus_export_formats.each do |f|
  #       format.send(f) { send("generate_#{f}") }
  #     end
  #   end
  # 
  # rescue Exception => error
  #   error_handler(error)
  # end
  
  # def custom_action
  # end
  # 
  # def custom_action_for_an_item
  # end


end