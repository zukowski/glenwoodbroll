$(document).ready(function() {
  // Enable edit field for the reel name
  $("#current_collection a").click(function() {
    $("#current_collection .label").hide()
    $("#current_collection form").show()
    return false;
  });

  // Change the current reel
  $("select#collection_id").change(function() {
    $(this).parent().submit();
  });
});
