It is a basic role play game where you have to defeat the army of each level
till you finish the game.

There are three types of rooms :
  - navigation room : where you will be prompted to move from with the available
                      directions                      
  - soldier room : where you will have to fight the soldiers in this room
                   and after you win you will be prompted to navigate from it
                   (you can skip the fight only once)
  - army room : where you will have to beat the army of the levels and after
                you win you will be moved to the next level if it exists
                (you can skip the fight only once)  

Game Setup:
  - to play the game run `docker-compose run app ruby game/game.rb` and you will instructed what to do
  - to run the specs run `docker-compose run app rspec`

Things I think I should have improved :
  - change the way I am printing the messages in the code to be more clear like `ValleyOfTheDead.speak(msg)`
  - change the set of the docker-compose to single docker file but due to time limits i just pushed my development setup
  - refactored the `Map` and the `RoomFactory` classes and moved the parts of creating the rooms to the `RoomFactory` class and added specs for it
  - test the behaviour of `move_player_to_current_room` room in the `GameManager` class by mocking the player input the way I did in the `InputTaker` specs
  - added commits more often instead of single commit
