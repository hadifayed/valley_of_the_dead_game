# valley_of_the_dead_game

Game Setup:
  - to play the game run `docker-compose run app ruby game/game.rb` and you will instructed what to do
  - to run the specs run `docker-compose run app rspec`

Things I think I should have improved :
  - change the way I am printing the messages in the code to be more clear like `ValleyOfTheDead.speak(msg)`
  - change the set of the docker-compose to single docker file but due to time limits i just pushed my development setup
  - refactored the `Map` and the `RoomFactory` classes and moved the parts of creating the rooms to the `RoomFactory` class and added specs for it
  - test the behaviour of `move_player_to_current_room` room in the `GameManager` class by mocking the player input the way I did in the `InputTaker` specs
  - added commits more often instead of single commit
