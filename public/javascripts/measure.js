function debug_msg (msg) {
  $("#debug_msgs").append(msg + "<br/>")
}
   
function AjaxTrackTime()
{
    debug_msg("again")
    $.post("/ajax_tracking/time_on_page");
 }
