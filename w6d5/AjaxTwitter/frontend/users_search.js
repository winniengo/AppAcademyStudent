var UsersSearch = function(el) {
  this.$el = $(el);
  this.input = this.$el.find('input');
  this.ul = this.$el.find('ul');
};


module.exports = UsersSearch;
