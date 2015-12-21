var React = require('react');

var RecipesListItem = React.createClass({
  getInitialState: function(){
    return { expanded: false };
  },
  toggleExpand: function(){
    this.setState({expanded: !this.state.expanded});
  },
  render: function () {
    var steps = "";
    if (this.state.expanded){
      steps = this.props.recipe.ingredients.map(function(ingredient){
        return <li key={ingredient.id}>{ingredient.name}</li>;
      });
    }
    return (
      <div onClick={this.toggleExpand}>
        {this.props.recipe.name}
        <ul>{steps}</ul>
      </div>
    );
  }
});

module.exports = RecipesListItem;
