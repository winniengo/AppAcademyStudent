var FollowToggle = require('./follow_toggle');

$(document).ready( function() {
  var $follow_buttons = $('button.follow-toggle');
  $follow_buttons.each(function () {
    new FollowToggle(this);
  })
});
