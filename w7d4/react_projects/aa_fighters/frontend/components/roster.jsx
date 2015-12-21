var React = require('react');
var FighterForm = require('./fighter_form.jsx');
var FighterData = require('./fighter_data.jsx');

var Roster = React.createClass({
  getInitialState: function(){
    return {
      inputVal: "",
      fighters: FighterStore.all()
    }
  },

  componentDidMount: function(){
    FighterStore.addChangeHandler(this.updateFighter);
    FighterStore.fetch();
  },

  componentWillUnmount: function(){
    FighterStore.removeChangeHandler(this.updateFighter);
  },

  updateFighter: function(){
    this.setState({ fighters: FighterStore.all() });
  },

  matches: function(){
    var match = false;
    var filtered = this.state.fighters.filter(function(f){
      if(f.name.indexOf(this.state.inputVal) !== -1){
        return true;
      }
    }.bind(this));

    return (match ? this.state.fighters : filtered);
  },

  //Input Handlers
  handleInput: function(e){
    this.setState({ inputVal: e.target.value });
  },

  render: function(){
    return(
      <div>

        <h1>Pick a Fighter</h1>
        <input value={this.state.inputVal}
               onChange={this.handleInput}
               type="text"/>

        <ul>{
          this.matches().map(function(fighter, idx){
            var boldClass = (fighter.name === this.state.inputVal) ? "bold" : "" ;
            return(
              <li key={idx} className={boldClass}>{fighter.name}</li>
            );
          }.bind(this))
        }</ul>

        <hr></hr>
        <FighterData name={this.state.inputVal} />
        <hr></hr>
        <FighterForm/>
      </div>
    )
  }
});

module.exports = Roster;
