var AppDispatcher = require('../dispatcher/dispatcher'),
    FilterConstants = require('../constants/filter_constants');

var FilterActions = {
  receiveAll: function(params) {
    AppDispatcher.dispatch({
      actionType: FilterConstants.FILTERS_RECEIVED,
      params: params
    });
  },

  receiveBound: function(bounds) {
    AppDispatcher.dispatch({
      actionType: FilterConstants.BOUND_FILTER_RECEIVED,
      bounds: bounds
    });
  },

  receiveSeating: function(seatings) {
    AppDispatcher.dispatch({
      actionType: FilterConstants.SEATING_FILTER_RECEIVED,
      seatings: seatings
    });
  },

};

module.exports = FilterActions;
