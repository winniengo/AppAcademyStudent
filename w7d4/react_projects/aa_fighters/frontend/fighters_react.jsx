var React = require('react'),
    ReactDom = require('react-dom'),
    Roster = require('./components/roster.jsx');

window.FighterStore = require('./stores/fighter_store.js');

ReactDom.render(
  <Roster/>,
  document.getElementById('root')
);
