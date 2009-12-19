$(document).ready(function() {
     
    AjaxTrackTime();
    debug_msg("First after pagereload")

    $.timer(10000, function (timer) {
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
