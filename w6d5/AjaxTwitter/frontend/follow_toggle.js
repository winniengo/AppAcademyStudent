var FollowToggle = function(button) {
  this.userId = button.dataset['userId'];
  this.followState = button.dataset['initialFollowState'];
  this.$button = $(button);
  this.render();
  this.$button.on("click", this.handleClick.bind(this));
};

FollowToggle.prototype.render = function () {
  if (this.followState === "unfollowed") {
    this.$button.html("Follow!");
    this.$button.prop("disabled", false);
  } else if (this.followState === "followed") {
    this.$button.html("Unfollow!");
    this.$button.prop("disabled", false);
  } else {
    this.$button.prop("disabled", true);
  }
};

FollowToggle.prototype.handleClick = function (e) {
  e.preventDefault();
  if (this.followState === "unfollowed") {
    var method = "POST";
    var newFollowState = "followed";
    this.followState = "following";
  } else {
    var method = 'DELETE';
    var newFollowState = "unfollowed";
    this.followState = "unfollowing";
  }
  this.render();

  $.ajax({
    url: "/users/" + this.userId + "/follow",
    type: method,
    dataType: "json",
    success: function() {
      this.followState = newFollowState;
      this.render();
    }.bind(this),
    error: function() {
      alert("error");
    }
  });
};


module.exports = FollowToggle;
