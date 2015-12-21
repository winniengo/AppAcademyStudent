var React = require('react'),
    BenchStore = require('../stores/bench');

var Index = React.createClass({
  getInitialState: function() {
    return ({
      benches: BenchStore.all()
    });
  },

  componentDidMount: function() {
    this.benchListener = BenchStore.addListener(this._onChange);
  },

  componentWillUnmount: function() {
    this.benchListener.remove();
  },

  _onChange: function() {
    this.setState({benches: BenchStore.all()});
  },

  render: function () {
    return(
      <ul>
        {this.state.benches.map(function (bench, i) {
          return <div key={i}>{bench.description}</div>;
        })}
      </ul>
    );
  }
});

module.exports = Index;
