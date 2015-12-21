var React = require('react');

var FighterData = React.createClass({
  render: function(){
    var fighter = FighterStore.find(this.props.name);

    if(!fighter){
      return <div></div>;
    }

    return(
      <div>
        <h1>{fighter.name}</h1>
        <div style={{width:100, height:100, backgroundColor: fighter.power}}>
          Power
        </div>
        <div>{fighter.history}</div>
      </div>
    )
  }
});

module.exports = FighterData;
