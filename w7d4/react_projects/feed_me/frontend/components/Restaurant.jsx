var React = require('react');
var RestaurantStore = require('../stores/restaurant');
var RestaurantActions = require('../actions/restaurant_actions');
var Menu = require('./Menu');
var Order = require('./Order');

var Restaurant = React.createClass({
  getInitialState: function () {
    var restaurantId = this.props.params.id;
    var restaurant = RestaurantStore.find(parseInt(restaurantId));
    return { restaurant: restaurant };
  },
  _updateState :function () {
    var restaurantId = parseInt(this.props.params.id);
    this.setState({ restaurant: RestaurantStore.find(restaurantId)});
  },
  componentDidMount: function () {
    this.restaurantToken = RestaurantStore.addListener(this._updateState);
    RestaurantActions.fetch();
  },
  componentWillUnmount: function () {
    this.restaurantToken.remove();
  },
  componentWillReceiveProps: function (newProps) {
    var restaurantId = parseInt(newProps.params.id);
    this.setState({restaurant: RestaurantStore.find(restaurantId)});
  },
  goToOrder: function () {
    var orderUrl = "restaurants/" +this.state.restaurant.id + "/order";
    this.props.history.push(orderUrl);
  },
  render: function () {
    return (
      <div>
        <div className="restaurant">
          <h2>{this.state.restaurant.name}</h2>
          <Menu {...this.state.restaurant} history={this.props.history}/>
        </div>
        {this.props.children}
      </div>
    );
  }
});

module.exports = Restaurant;
