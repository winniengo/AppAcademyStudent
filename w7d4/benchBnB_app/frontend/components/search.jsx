/* globals google */
var React = require('react'),
    Map = require('./map'),
    Index = require('./index'),
    FilterStore = require('../stores/filter'),
    ApiUtil = require('../util/api_util'),
    Filter = require('../components/filter');

var Search = React.createClass({
  getInitialState: function() {
    return {params: FilterStore.all()};
  },

  componentDidMount: function() {
    this.filterListener = FilterStore.addListener(this._onChange);
    // re-fetches benches when the params in the filter store changes
  },

  componentWillUnmount: function() {
    this.filterListener.remove();
  },

  _onChange: function() {
    this.setState({params: FilterStore.all()});
    ApiUtil.fetchBenches(this.state.params); // fetch benches with current params
  },

  clickMapHandler: function(query) {
    this.props.history.pushState(null, '/benches/new', query)
  },

  render: function() {
    return(
      <div>
        <Map handler={this.clickMapHandler}/>
        <Filter/>
        <Index/>
      </div>
    );
  }
});

module.exports = Search;
