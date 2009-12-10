module StoriesHelper


  def awesome_truncate(text, length = 30, truncate_string = "...")
    return if text.nil?
    
    l = length - truncate_string.chars.length
    new_text = text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
    
    new_text.split(" ").inject("") { |new_title, word| new_title = new_title + " " + word[0..22] }
  
  end



# =link_to_function "¡Qué puta mierda!(#{story_new.rated_top})", "vote_story(#{story_new.id}, 'top', 'collection')", :class => "vote_link"
# -else
# =link_to_function "¡Qué puta mierda!(#{story_new.rated_top})", "alert('Ya hay un voto tuyo para esta historia')", :class => "inactive"

  def rated_story?(story)
    if logged_in?
      unless story.rated_by?(current_user)
        class_name = "not_rated"
      else
        class_name = "rated"
      end
    elsif cookies[:vcode]
      unless story.rated_by_cookie?(cookies[:vcode])
        class_name = "not_rated"
      else
        class_name = "rated"
      end
    else
      class_name = "not_rated"
    end    
  end


  def thumbs_up_link(story)
    submit_tag("&nbsp;", :disabled => (rated_story?(story) == "rated"), :class => "#{rated_story?(story)} thumb_input")
  end

  #"vote_story(#{story.id}, 'top', 'collection')"

  def thumbs_down_link(story)
    submit_tag("&nbsp;", :disabled => (rated_story?(story) == "rated"), :class => "#{rated_story?(story)} thumb_input")
  end



  def comment_bubble_link(story)
    
    link_class = ((story.root_comments.size == 0) ? "zero" : "not_zero"     )
    link_to("#{story.root_comments.size}", story_path(story, :anchor => "comments"), :class => link_class)
    
  end

  def category_as_tag(story)
    icon_class = (story.category.name.length > 4) ? "category_medium" : "category_small" 
    
    link_to(story.category.name+"&nbsp;&nbsp;&nbsp;", category_path(story.category), :class => icon_class + " fix tag")
    
  end


end
