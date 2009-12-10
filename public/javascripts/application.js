function fill_with_fake_data_story(){
  $("#story_title").attr("value", "Dies ist eine Fake Story")  
  $("#story_body").attr("value", "Dies ist eine Fake StoryDies ist eine Fake StoryDies ist eine Fake StoryDies ist eine Fake StoryDies ist eine Fake Story")  
  $("#story_category_id").attr("value", "2")  
}


function fill_with_fake_data_user(){
  $("#user_login").attr("value", "Fabian99")  
  $("#user_email").attr("value", "fabian.dittrich@gmail.com")    
  $("#user_password").attr("value", "red098")      
  $("#user_password_confirmation").attr("value", "red098")      

  $("#user_birthdate_1i").attr("value", "1981")
  $("#user_birthdate_2i").attr("value", "3")
  $("#user_birthdate_3i").attr("value", "29")

  $("#story_body").attr("value", "Dies ist eine Fake StoryDies ist eine Fake StoryDies ist eine Fake StoryDies ist eine Fake StoryDies ist eine Fake Story")  
  $("#story_category_id").attr("value", "2")  
}

function round_corners() {
  $(".round_corners").corners();
  $(".brown_background").corners("10px");
}

function check_regexp(value, regex) {
  if (value.match(regex)) {
    return true;
  } else {
    return false;
  }
}



function open_reply_to_comment(object) {
  var parent_id = object.parents(".comment").attr("id").split("_")[1]
  var content = '<div style="display: none;" class="reply_comment"><h3>Tu respuesta:</h3><form id="comment_form" method="post" action="/comments?parent='+parent_id+'" class="comment_form"><div style="margin: 0pt; padding: 0pt;"></div><textarea id="story_comment_field" rows="6" name="comment[comment]" cols="1"/><div class="fr"><a href="/stories/dies-ist-eine-fake-story" class="cancel_reply_to_comment">Cancelar</a><input class="comment_submit button button_blue_small" type="submit" value="Enviar" style="margin-top: 5px;" name="commit"/></div></form><div class="c"/></div>';

  $("#comment_"+parent_id).append(content);
  $(".reply_comment").show();
  
  object.parents(".comment").find(".comment_action").toggle();

      var validator = object.parents(".comment").find("form").validate({
        rules: {
          "comment[comment]": {
            required: true,
            minlength: 20
          }
        },
        messages: {
          "comment[comment]": {
            required: "¿Y donde esta tu comentario?",
            minlength: "Vamos! Un poco más largo por favor. 20 letras minimo!"
          }
        },
        submitHandler: function(form) {submit_form(form)}
      });



}

function submit_form (form) {
    $("input:submit", form).after($("#spinner").show());
    $("input:submit", form).attr("disabled", true).attr("value", "Enviando...");
    form.submit();
}

$(document).ready(function() {
  
  $.facebox.settings.opacity=0.5;  
  
  $("a.reply_to_comment").live("click", function(){
    open_reply_to_comment($(this));
    return false;
  });

  $("a.cancel_reply_to_comment").live("click", function(){
    $(this).parents(".comment").find(".comment_action").toggle();
    $(this).parents(".reply_comment").remove();
    
    return false;
  });

  $("a.show_children_link").live("click", function(){
    $(this).parents(".parent").find(".child").toggle();
    return false;
  });

  round_corners();

    $.timer(2000, function (timer) {
      var fade_time = 200;
      $("#top_signup_link").animate({opacity: 1.0}, fade_time).animate({opacity: 0.1}, fade_time, function() {
        $("#top_signup_link").animate({opacity: 0.1}, fade_time).animate({opacity: 1.0}, fade_time)
      })
      timer.stop();
    });  
    $.timer(5000, function (timer) {
      var fade_time = 200;
      $("#top_signup_link").animate({opacity: 1.0}, fade_time).animate({opacity: 0.1}, fade_time, function() {
        $("#top_signup_link").animate({opacity: 0.1}, fade_time).animate({opacity: 1.0}, fade_time)
      })
      timer.stop();
    });  
});
