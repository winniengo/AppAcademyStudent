var ApiActions = require('../actions/api_actions'),
    FilterStore = require('../stores/filter');

var ApiUtil = {
  fetchBenches: function(params) {
    debugger
    $.ajax({
      url: "api/benches",
      data: {bounds: params.bounds, seating: params.seating},
      success: function (benches) {
        ApiActions.receiveAll(benches);
      }
    });
  },

  createBench: function(newBench) {
    $.ajax({
      url: "api/benches",
      method: "POST",
      data: {bench: newBench},
      success: function(bench) {
        ApiActions.receiveSingle(bench);
      }
    })
  }
};

module.exports = ApiUtil;
