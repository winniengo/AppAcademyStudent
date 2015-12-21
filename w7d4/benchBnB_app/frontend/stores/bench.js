var Store = require('flux/utils').Store,
    AppDispatcher = require('../dispatcher/dispatcher'),
    BenchConstants = require('../constants/bench_constants');

var BenchStore = new Store(AppDispatcher);
var _benches = [];

BenchStore.all = function () {
  return _benches.slice();
};

var resetBenches = function(benches){
    _benches = benches;
};

BenchStore.__onDispatch = function (payload) {
  switch(payload.actionType) {
    case BenchConstants.BENCHES_RECEIVED:
      resetBenches(payload.benches);
      BenchStore.__emitChange();
      break;
    }
};

module.exports = BenchStore;
