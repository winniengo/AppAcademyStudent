var AppDispatcher = require('../app_dispatcher');

// These are beefy action creators. I would later refactor these into an
// api_util and recipe action file, but for now this is fine
var RecipeActions = {
  fetch: function () {
    $.ajax({
      url: "/api/recipes",
      dataType: "json",
      success: function(recipes){
        AppDispatcher.dispatch({
          actionType: "RECEIVE_RECIPES",
          recipes: recipes
        });
      }
    });
  },
  create: function(recipe){
    $.post("/api/recipes", {recipe: recipe}, function(recipe){
      AppDispatcher.dispatch({
        actionType: "ADD_RECIPE",
        recipe: recipe
      });
    });
  }
}

module.exports = RecipeActions;


