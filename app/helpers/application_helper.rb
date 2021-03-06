# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  include TagsHelper


  def get_user_avatars_for_experiment_in_particular_order
    r=User.find(get_session.avatars_order)
    users = get_session.avatars_order.map{|id| r.detect{|each| each.id == id}}
  end


  def get_manipulation_level
    return "error-in-manipulation-level" if !get_session
    get_session && get_session.visitor.manipulation_level.split("_")[0]
  end

  def get_adaptation_level
    return "error-in-adaptation-level" if !get_session
    get_session && get_session.visitor.manipulation_level.split("_")[1]
  end

  def get_title_for_story(story)
    if !session[:experiment] || !story.experiment_story
      story.title  || "no title"
    elsif session[:experiment] && (get_manipulation_level != "ugc" && get_manipulation_level != "all")
      story.title_ne || "no title"
    elsif session[:experiment] && (get_manipulation_level == "ugc" || get_manipulation_level == "all")
      story.send("title_#{get_adaptation_level}") || "no title"
    end
  end
  
  def get_body_for_story(story)
    if !session[:experiment] || !story.experiment_story
      story.body
    elsif session[:experiment] && (get_manipulation_level != "ugc" && get_manipulation_level != "all")
      story.body_ne || "no body"
    elsif session[:experiment] && (get_manipulation_level == "ugc" || get_manipulation_level == "all")
      story.send("body_#{get_adaptation_level}")  || "no body"
    end
  end
    
    
  def get_session
    return false if (!session[:visitor_session_id] or !session[:experiment])
    visitor_session = VisitorSession.find_by_session_id(session[:visitor_session_id])

    if !visitor_session
      session[:experiment] = false
      return false
    end
    
    visitor_session
  end

  def  get_country_name_for_object(object)
    return object.location.country_name if object.location
    "No sabemos el país"
  end


  def get_flag_image(object, mode)
    return "" if get_session && session[:experiment] && !(get_session.visitor.manipulation_level.split("_")[0] == "ugc" or get_session.visitor.manipulation_level.split("_")[0] == "all")

    if mode == "meta"
      return image_tag("flags/mx.png", :title =>  "México", :class => "tooltip") if get_session && (get_session.visitor.manipulation_level == "ugc_mx" || get_session.visitor.manipulation_level == "all_mx")
      return image_tag("flags/es.png", :title =>  "España", :class => "tooltip") if get_session && (get_session.visitor.manipulation_level == "ugc_es" || get_session.visitor.manipulation_level == "all_es")
    elsif mode == "profile"
      return image_tag("flags/mx.png", :title =>  "México", :class => "tooltip user_box_flag") if get_session && (get_session.visitor.manipulation_level == "ugc_mx" || get_session.visitor.manipulation_level == "all_mx")
      return image_tag("flags/es.png", :title =>  "España", :class => "tooltip user_box_flag") if get_session && (get_session.visitor.manipulation_level == "ugc_es" || get_session.visitor.manipulation_level == "all_es")
    end


    if mode == "meta"
      if !object.location_id
        image_tag("flags/xx.png", :title =>  get_country_name_for_object(object), :class => "tooltip")            
      else
        image_tag("flags/#{object.location.country_code.downcase}.png", :title =>  get_country_name_for_object(object), :class => "tooltip")      
      end
    elsif mode == "profile"
      if !object.location
        image_tag("flags/xx.png", :class => "user_box_flag tooltip", :title => get_country_name_for_object(object))
      else
        image_tag "flags/#{object.location.country_code.downcase}.png", :class => "user_box_flag tooltip", :title => get_country_name_for_object(object)
      end
    end


    


  end

  def link_to_profile(user, options = {})
      options[:size] ||= :medium
      
      flag = get_flag_image(user, "profile")
      output = flag
      
      if user.avatar_file_name
        user_pic = link_to image_tag(user.avatar.url(options[:size]), :alt => h(user.login), :title => h(user.login), :class => "icon", :id => "user_profile_link"), (options[:change_photo] ? account_avatar_path : user_path(user))
      else
        user_pic = link_to image_tag("/avatars/#{options[:size]}/missing_#{user.gender}.png", :alt => h(user.login), :title => h(user.login), :class => "icon", :id => "user_profile_link"), (options[:change_photo] ? account_avatar_path : user_path(user))
      end
      
      output << user_pic
      output << "<br/>"
      user_name_link =link_to truncate(user.login, 15), user_path(user), :class => "normal_color dashed", :id => "user_profile_link"
      output << user_name_link
      content_tag(:div, output, :class => "userbox #{options[:size]}")
  end


  def author(object)
    if object.is_a? Story
      if object.user and !object.anonymous
        link_to object.user.login, user_path(object.user), :id => "user_profile_link"
      else
        "anónimo"
      end
    else object.is_a? Comment
      unless object.user_id > 0
        "anónimo"
      else
        user = User.find(object.user_id)
        link_to user.login, user_path(user), :id => "user_profile_link"
      end
    end
  end


  
  def meta_info(object)
    output = ""

    if object.is_a?(Comment)
      output << content_tag(:div, get_flag_image(object, "meta"), :class => "flag")
      output << content_tag(:div, "#{author(object)} el #{my_date(object.created_at)}", :class => "text")

    elsif object.is_a?(Story)
      output << content_tag(:div, get_flag_image(object, "meta"), :class => "flag")
      

      if get_session
        output << content_tag(:div, "#{author(object)} el #{my_date(Date.today - (rand(3)+1).days - (rand(10)+1).hours - (rand(59)+1).minutes )}", :class => "text")
      else
        output << content_tag(:div, "#{author(object)} el #{my_date(object.created_at)}", :class => "text")
      end


      
      
      output << content_tag(:div, image_tag("story_footer_seperator.png"), :class => "text fix")
      output << content_tag(:div, "Categoría: #{link_to(object.category.name, category_path(object.category))}", :class => "category text")      
    end
        
    output
  end


  def production?
    return RAILS_ENV=="production"
  end



  def get_return_path(p)
    return "/" if  p[:controller] == "stories" and p[:action] == "index"
    return "/#{p[:controller]}/#{p[:action]}" unless (p[:tiempo] or p[:ordenar_por] or p[:controller] == "categories")
    return "/#{p[:controller]}/#{p[:action]}?tiempo=#{p[:tiempo]}" if p[:tiempo]
    return "/#{p[:controller]}/#{@category.name}?ordenar_por=#{p[:ordenar_por]}" if p[:ordenar_por]
    return "/#{p[:controller]}/#{@category.name}"    
    end

  def visitor_country_id_or_selected_country_id
    return session[:selected_country].to_i if session[:selected_country]
    
    return Country.find_by_iso(session[:geo_location].country_code.upcase).used_id.to_i if (session[:geo_location] && session[:country_selector] == "local")
    
    
    return "all"
    
    #unless session[:geo_location]
    #
  end

  def link_to_facebox(name, options = {}, html_options = {})
    link_to(name, options, html_options.merge({ :rel=> "facebox" }))
  end

  def show_payment_status(payment)
    
    output = ""

    if payment.is_payed
      output << "Markeado como pagado el #{my_date(payment.payed_at)}"
    else
      output << content_tag(:span, "No pagado", :class => "red bold")
    end
    
     
    
  end


  def get_flag_for_user(user)
    return (image_tag "flags/" + user.country.iso.upcase + ".gif")
  end

  def get_flag_for_bizname(bizname)
    return (image_tag "flags/" + bizname.country_code.upcase + ".gif")
  end



  def my_date(date)
    date.strftime("%d/%m/%Y a las %H:%M hrs")
  end

  def my_date_kpis(date)
    date.strftime("%d.%m.%Y")
  end



  def info_field(label, value)
    
    output = ""
    output << content_tag(:div, label, :class => "info grid_2 alpha")
    output << content_tag(:div, value, :class => "value grid_4 omega")

  end


  def photo_and_user_link(user, avatar_type)

    output = ""
    output << '<div class="thumb_photo_in_table">'
    if user.has_photo?
      output << '<div class="photo fl">' +  image_tag(user.avatar(avatar_type)) + '</div>'    
    end
    output << '<div class="username fl">' +  link_to(user.fullname, user_path(user)) + '</div>'  
    output << '</div">'
                
  end


  def render_main_tabnav(classname)
    
    case classname
    when "Administrator": return (tabnav "admin_main")
    when "Distributor": return (tabnav "distributor_main")
    when "Author": return tabnav("author_main")
    end

  end

  def content_type_attrs(content_type = "text/html")
    { "http-equiv" => "Content-type", "content" => "#{content_type}; charset=utf-8" }
  end


  def spanish_month_names
    return ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  end 

  def title(page_title)
    content_for(:title) { page_title }
  end

  def link_to_home_area
    if current_user.class.name == "Author"
        return (link_to("Inicio", account_home_author_path))
    elsif current_user.class.name == "Distributor"
        return (link_to "Inicio", account_home_distributor_path)
    elsif current_user.class.name == "Administrator"
        return (link_to("Inicio", home_admin_path))
    end
    
    
  end




    def page_entries_info(collection, options = {})
      entry_name = options[:entry_name] ||
        (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))
      
      if collection.total_pages < 2
        case collection.size
        when 0; "No hay #{entry_name.pluralize}"
        when 1; "Mostrando <b>1</b> #{entry_name}"
        else;   "Mostrando <b>todos las #{collection.size}</b> #{entry_name.pluralize}"
        end
      else
        %{Mostrando #{entry_name.pluralize} <b>%d&nbsp;-&nbsp;%d</b> de <b>%d</b> en total} % [
          collection.offset + 1,
          collection.offset + collection.length,
          collection.total_entries
        ]
      end
    end









end
