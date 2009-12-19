$(document).ready(function() {
     
    AjaxTrackTime();
    debug_msg("First after pagereload")

    var times = 120;
    
    $.timer(10000, function (timer) {
      times = times - 1;
      if (times <= 0) {
        timer.stop();        
      };
      
      AjaxTrackTime();
    });  
   
});

function debug_msg (msg) {
  $("#debug_msgs").append(msg + "<br/>")
}
   
function AjaxTrackTime()
{
    debug_msg("again")

    $.post("/ajax_tracking/time_on_page");
 }
