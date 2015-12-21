var React = require('react'),
    FilterActions = require('../actions/filter_actions'),
    History = require('react-router').History,
    LinkedStateMixin = require('react-addons-linked-state-mixin');

module.exports = React.createClass({
  mixins: [LinkedStateMixin, History],

  blankAttrs: {
    minSeats: 0,
    maxSeats: 4,
  },

  getInitialState: function() {
    return this.blankAttrs;
  },

  createFilter: function(e) {
    var filter = {};

    Object.keys(this.state).forEach(function(key) {
      filter[key] = this.state[key];
    }.bind(this));

    FilterActions.receiveAll(filter);
  },

  render: function() {
    return(
      <form className='new-filter' onSubmit={this.createFilter}>
        <br/>
        <div>
          <label htmlFor='filter-min-seats'>Min Seats: </label>
          <br/>
          <input
            type='text'
            id='filter-min-seats'
            valueLink={this.linkState('minSeats')}
          />
        </div>

        <div>
          <label htmlFor='filter-max-seats'>Max Seats: </label>
          <br/>
          <input
            type='text'
            id='filter-max-seats'
            valueLink={this.linkState('maxSeats')}
          />
        </div>

      <br/>
      <button>Search Benches!</button>
      </form>
    );
  }
});
