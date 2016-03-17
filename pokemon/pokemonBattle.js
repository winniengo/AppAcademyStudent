var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

pikachu = {
	name: "PIKACHU",
	attack: 2,
	hp: 31,
	level: 10
}

squirtle = {
	name: "SQUIRTLE",
	attack: 2,
	hp: 30,
	level: 10
}

var pokemonBattle = {
	attack: function(pokemon1, pokemon2) {
		pokemon2.hp -= pokemon1.attack;
		console.log(pokemon1.name + " attacked!");
	},

	potion: function(pokemon) {
		pokemon.hp += 5
		console.log("used potion on " + pokemon.name + "!");
	},

	run: function(pokemon) {
		pokemon.hp = 0;
	},

	stats: function(pokemon1, pokemon2) {
		console.log("---")
		console.log(pokemon1.name + " hp: " + pokemon1.hp);
		console.log(pokemon2.name + " hp: " + pokemon2.hp);
		console.log("---")
	},

	results: function(pokemon1, pokemon2) {
		if (pokemon1.hp > 0) {
			console.log(pokemon1.name + " won!");
		} else {
			console.log(pokemon2.name + " won!");
		}
		console.log("battle over!");
		reader.close();
	},

	promptUser: function(myPokemon, oppPokemon, playMove) {
		console.log("What should " + myPokemon.name + " do?");
		reader.question("Select 'a' for attack, 'p' for potion', 'r' for run: ", function (userInput) {
			playMove(userInput, myPokemon, oppPokemon);
		});
	},

	makeMove: function(choice, myPokemon, oppPokemon) {
		if (choice === "a") {
			this.attack(myPokemon, oppPokemon);
			this.attack(oppPokemon, myPokemon);
			this.stats(myPokemon, oppPokemon);
		} else if (choice === "p") {
			this.potion(myPokemon);
			this.attack(oppPokemon, myPokemon);
			this.stats(myPokemon, oppPokemon);
		} else if (choice === "r") {
			this.run(oppPokemon);
		}

		if (myPokemon.hp > 0 && oppPokemon.hp > 0) {
			this.play(myPokemon, oppPokemon);
		} else {
			this.results(myPokemon, oppPokemon);
		}
	},

	play: function(myPokemon, oppPokemon) {
		this.promptUser(myPokemon, oppPokemon, this.makeMove.bind(this));
	}
};


pokemonBattle.play(pikachu, squirtle);
