var React = require('react');

var FighterForm = React.createClass({
  getInitialState: function(){
      return {
        newName: "",
        newPower: "#000000",
        newHistory: ""
      }
  },

  handleName: function(e){
    this.setState({ newName: e.target.value })
  },

  handlePower: function(e){
    this.setState({ newPower: e.target.value });
  },

  handleHistory: function(e){
    this.setState({ newHistory: e.target.value })
  },

  handleNewFighter: function(e){
    e.preventDefault();

    var fighters = this.state.fighters;
    var newFighter = {
      name: this.state.newName,
      power: this.state.newPower,
      history: this.state.newHistory
    };

    FighterStore.create({ fighter: newFighter});

    this.setState({
      inputVal: newFighter.name,
      newName: "",
      newPower: "",
      newHistory: ""
    });
  },

  render: function(){
    return(
      <div>
        <h2>New Fighter!</h2>
        <form onSubmit={this.handleNewFighter}>
          Name: <input type="text"
                       onChange={this.handleName}
                       value={this.state.newName}/>
          <br/>
          Power: <input type="color"
                        onChange={this.handlePower}
                        value={this.state.newPower}/>
          <br/>
          History: <input type="text"
                          onChange={this.handleHistory}
                          value={this.state.newHistory}/>
          <br/>
          <input type="submit" value="New Fighter"/>
        </form>
      </div>
    )
  }
})

module.exports = FighterForm;
