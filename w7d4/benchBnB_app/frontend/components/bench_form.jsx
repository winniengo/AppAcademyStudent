var React = require('react'),
    ApiUtil = require('../util/api_util'),
    History = require('react-router').History,
    LinkedStateMixin = require('react-addons-linked-state-mixin');

module.exports = React.createClass({
  mixins: [LinkedStateMixin, History],

  blankAttrs: {
    description: '',
    lat: '',
    lng: '',
    seating: 4,
  },

  getInitialState: function () {
    return this.blankAttrs;
  },

  componentDidMount: function () {
    if (this.props.location.query) {
      this.setState({
        lat: this.props.location.query.lat,
        lng: this.props.location.query.lng});
    }
  },

  createBench: function (event) {
    event.preventDefault();

    var bench = {};

    Object.keys(this.state).forEach(function (key) {
      bench[key] = this.state[key];
    }.bind(this));

    ApiUtil.createBench(bench);

    this.setState(this.blankAttrs); // reset form
    this.props.history.pushState(null, '/', {});
  },

  render: function () {
    return(
      <form className='new-bench' onSubmit={this.createBench}>
        <div>
          <label htmlFor='bench-description'>Description: </label>
          <br/>
          <input
            type='text'
            id='bench_description'
            valueLink={this.linkState('description')}
          />
        </div>

        <div>
          <label htmlFor='bench-lat'>Latitude: </label>
          <br/>
          <input
            type='text'
            id='bench_lat'
            valueLink={this.linkState('lat')}
          />
        </div>

        <div>
          <label htmlFor='bench-lng'>Longitude: </label>
          <br/>
          <input
            type='text'
            id='bench_lng'
            valueLink={this.linkState('lng')}
          />
        </div>

        <br/>
        <button>Create Bench!</button>
      </form>
    );
  }
});
