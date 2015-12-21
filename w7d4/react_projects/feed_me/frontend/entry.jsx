var React = require('react');
var ReactDOM = require('react-dom');
var Router = require('react-router').Router;
var Route = require('react-router').Route;

var App = require('./components/App');
var Order = require('./components/Order');
var Restaurant = require('./components/Restaurant');

var routes = (
  <Route path="/" component={App}>
    <Route path="restaurants/:id" component={Restaurant}>
      <Route path="order" component={Order} />
    </Route>
  </Route>
);

document.addEventListener('DOMContentLoaded', function () {
  var content = document.querySelector('#content');
  ReactDOM.render(<Router>{routes}</Router>, content);
});
