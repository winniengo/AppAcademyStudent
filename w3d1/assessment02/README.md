# WAR!

## Rules

* You have **1 hour** for the assessment. Do not worry if you do not
  complete all the assessment; finish as much as you can.
* Descriptions of each method to implement are written into the `lib/`
  files. For each `lib/` file, there is a corresponding `spec/` file.
* Run the specs as you solve the assessment. Solve the assessment in
  this order:
* WARNING: the game spec is a bit harder than the others, be prepared.

```
bundle exec rspec spec/card_spec.rb
bundle exec rspec spec/stack_spec.rb
bundle exec rspec spec/ai_player_spec.rb
bundle exec rspec spec/game_spec.rb
```

* Wait until you finish to run `bundle exec rspec spec`, which will
  run all the tests. Do this as a final check that you have them all
  passing.
* If a failing spec confuses you, look at the spec file to see if you
  can discern what it is asking of you. There are sometimes comments
  in the spec files to help you.
* Please ask your TAs any questions. If you get stuck or don't know
  why something is failing; ask. TAs will let you know whether they
  can answer your question, so ask anything.
    * Do not use the internet or prior notes, please.
* To submit:
    * Rename the directory `first_name_last_name`.
    * ZIP it (you can use OS X's built in zip functionality)
    * Use `.zip`; no boutique formats please :-)
    * Upload to progress tracker (http://progress.appacademy.io/).

## Hint

* **USE THE SPECIFIED API**. We have carefully guided you on the
  methods you'll need in the files to let you easily write
  `AIPlayer`. Use these methods; you'll see that we use
  `expect(...).to receive(...)` in some files to setup objects for the
  test.

## Game Rules

* The goal is to win ALL the cards leaving your opponent with none.

0. Players are each dealt half the deck in an alternating pattern.
1. Players each take their top card and lay it face UP.
2. If the cards' rank is the same i.e. 3 of clubs and 3 of hearts,
   players take ANOTHER card and lay it face DOWN, then repeat step 1.
3. If the last drawn cards are different ranks, all the cards drawn in
   this round are awarded to the drawer of the higher ranked card.
4. If either player runs out of cards at any time, that player loses and
   the game ends.

Further game rules are described on [the bicycle site][war-rules],
but the above is the limit of what you need to implement.

[war-rules]: http://www.bicyclecards.com/card-games/rule/war

**Copyright App Academy, please do not post online**
