/* globals google */
var React = require('react'),
    ReactDOM = require('react-dom'),
    ApiUtil = require('../util/api_util'),
    BenchStore = require('../stores/bench'),
    FilterStore = require('../stores/filter'),
    FilterActions = require('../actions/filter_actions');

var mapCenter = { lat: 37.7758, lng: -122.435 }; // San Francisco

var Map = React.createClass({
  getInitialState: function() {
    return ({
      markers: []
    });
  },

  componentDidMount: function() {
    var map = ReactDOM.findDOMNode(this.refs.map),
        options = {
          center: mapCenter,
          zoom: 13
        };

    this.map = new google.maps.Map(map, options);
    this.benchListener = BenchStore.addListener(this._onChange);
    this.listenForMove();
    this.listenForClick();
  },

  listenForMove: function() {
    var that = this;

    google.maps.event.addListener(this.map, 'idle', function() {
      var bounds = that.map.getBounds();
      var params = {
            "northEast": {"lat": bounds.getNorthEast().lat(), "lng": bounds.getNorthEast().lng()},
            "southWest": {"lat": bounds.getSouthWest().lat(), "lng": bounds.getSouthWest().lng()}
          }

      // FilterActions.receiveBound(params);
      FilterActions.receiveAll(params);
    });
  },

  listenForClick: function() {
    this.map.addListener('click', function(e) {
      this.props.handler({
        "lat": e.latLng.lat(),
        "lng": e.latLng.lng()});
    }.bind(this));
  },

  componentWillUnmount: function() {
    this.benchListener.remove();
  },

  _onChange: function() {
    var benches = BenchStore.all();

    this.state.markers.forEach(this.removeMarker);
    this.setState({markers: benches.map(this.addMarker)});
  },

  removeMarker: function(marker) {
    marker.setMap(null);
  },

  addMarker: function(bench) {
    var pos = new google.maps.LatLng(bench.lat, bench.lng),
        marker = new google.maps.Marker({
          position: pos,
          map: this.map
        });

    return marker;
  },

  render: function() {
    return (
      <div className="map" ref="map" />
    );
  }
});

module.exports = Map;
