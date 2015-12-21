var Store = require('flux/utils').Store;
var AppDispatcher = require('../app_dispatcher');

var RecipeStore = new Store(AppDispatcher);

//After initial testing these lines can be removed
//window.RecipeStore = RecipeStore;
//window.AppDispatcher = AppDispatcher;

var _recipes = [];
RecipeStore.all = function () {
  return _recipes.slice();
};

RecipeStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case "RECEIVE_RECIPES":
      resetRecipes(payload.recipes);
      break;
    case "ADD_RECIPE":
      createRecipe(payload.recipe);
      break;
  }
};

var resetRecipes = function (recipes) {
  _recipes = recipes;
  RecipeStore.__emitChange();
};

var createRecipe = function (recipe) {
  _recipes.push(recipe);
  RecipeStore.__emitChange();
}

module.exports = RecipeStore;
