var _fighters = [],
    _callbacks = [];

var FighterStore = {
  all: function(){
    return _fighters.slice();
  },

  find: function(name){
    return _fighters.find(function(f){
      return f.name === name;
    });
  },

  fetch: function(){
    $.get('api/fighters', {}, function(fighters){
      _fighters = fighters;
      FighterStore.changed();
    });
  },

  create: function(fighter){
    $.post('api/fighters', fighter, function(fighter){
      _fighters.push(fighter);
      FighterStore.changed();
    })
  },

  addChangeHandler: function(cb){
    _callbacks.push(cb);
  },

  removeChangeHandler: function(cb){
    var idx;

    for(var i = 0; i < _callbacks.length; i+=1){
      if(cb === _callbacks[i]){
        idx = i;
        break;
      }
    }

    if(!idx){ return; }

    _callbacks.splice(idx,1);
  },

  changed: function(){
    _callbacks.forEach(function(cb){
      cb();
    })
  }
};

module.exports = FighterStore;
