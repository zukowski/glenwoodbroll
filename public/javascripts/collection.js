// Some JS to edit the name of the current collection
$(document).ready(function() {
  $("#current_collection a").click(function() {
    $("#current_collection .label").hide()
    $("#current_collection form").show()
    return false;
  });
});
