var React = require('react');
var History = require('react-router').History;

var RestaurantsIndexItem = React.createClass({
  mixins: [History],
  viewRestaurant: function () {
    var restaurantUrl = "restaurants/" + this.props.id;
    this.history.push(restaurantUrl);
  },
  render: function () {
    return (
      <div>
        <ul>
          <li onClick={this.viewRestaurant}>
            { this.props.name }
          </li>
        </ul>
      </div>
    );
  }
});

module.exports = RestaurantsIndexItem;
