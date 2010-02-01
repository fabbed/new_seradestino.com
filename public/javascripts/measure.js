function debug_msg (msg) {
  $("#debug_msgs").append(msg + "<br/>")
}
   
function AjaxTrackTime()
{
    debug_msg("again")
    $.post("/ajax_tracking/time_on_page");
 }


function AjaxTrackOnLoadTime()
{
    debug_msg("Onload")
    $.post("/ajax_tracking/time_on_page_on_load");
 }



function FirstAjaxTrackTime()
{
    debug_msg("FIRST")
    $.post("/ajax_tracking/time_on_page");
 }
