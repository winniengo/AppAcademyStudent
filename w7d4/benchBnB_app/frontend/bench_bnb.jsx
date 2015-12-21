var React = require('react'),
    ReactDOM = require('react-dom'),
    Router = require('react-router').Router,
    Route = require('react-router').Route,
    IndexRoute = require('react-router').IndexRoute;

var Search = require('./components/search'),
    App = require('./components/app'),
    BenchForm = require('./components/bench_form');

 var routes = (
     <Route path="/" component={App}>
       <IndexRoute component={Search}/>
       <Route path="benches/new" component={BenchForm} />
     </Route>
 );

document.addEventListener("DOMContentLoaded", function () {
  var root = document.getElementById('root');
  ReactDOM.render(<Router>{routes}</Router>, root);
});
