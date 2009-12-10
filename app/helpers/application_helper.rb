# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  include TagsHelper


  def get_flag_image(object)
    return "flags/xx.png" if !object.location
    "flags/#{object.location.country_code}.png"
  end

  def link_to_profile(user, options = {})
      
      options[:size] ||= :medium
      flag = image_tag get_flag_image(user), :class => "user_box_flag"
      output = flag
      user_pic = link_to image_tag(user.avatar.url(options[:size]), :alt => h(user.login), :title => h(user.login), :class => "icon", :id => "user_profile_link"), user_path(user)
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
      unless object.user
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
      output << "#{author(object)} el #{my_date(object.created_at)}"      

    elsif object.is_a?(Story)
      output << content_tag(:div, (image_tag("flags/#{object.country_code.downcase}.png", :title => object.country.name, :class => "tooltip") if object.country_id), :class => "flag")

      output << content_tag(:div, "#{author(object)} el #{my_date(object.created_at)}", :class => "text")
      output << content_tag(:div, image_tag("story_footer_seperator.png"), :class => "text")
      output << content_tag(:div, "Categoría: #{link_to 'Amor', '#'}", :class => "category text")      
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
