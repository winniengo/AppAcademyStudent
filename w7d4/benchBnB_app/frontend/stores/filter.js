var Store = require('flux/utils').Store,
    AppDispatcher = require('../dispatcher/dispatcher'),
    FilterConstants = require('../constants/filter_constants');

var FilterStore = new Store(AppDispatcher);
var _params = {seating: {}, bounds: {}};

FilterStore.all = function() {
  return _params;
};

var resetFilters = function(params) {
  _params = params;
};

var updateBoundFilter = function(param) {
  _params.seating = param;
}

var updateSeatingFilter = function(param) {
  _params.bounds = param;
}

FilterStore.__onDispatch = function(payload) {
  switch(payload.actionType) {
    case FilterConstants.FILTERS_RECEIVED:
      resetFilters(payload.params);
      FilterStore.__emitChange();
      break;
    case FilterConstants.BOUND_FILTER_RECEIVED:
      updateBoundFilter(payload.params);
      FilterStore.__emitChange();
      break;
    case FilterConstants.SEATING_FILTER_RECEIVED:
      updateSeatingFilter(payload.params);
      FilterStore.__emitChange();
      break;
  }
};

module.exports = FilterStore;
