# README
- I used ActionCable to implement real time marks check between the players
- ActionCable channels are define by game_id & current_player.id ex: game_channel_1_1
- Authentication is simple (without devise)
- Check board "win" or "no one" send to both player channels, "next" send only to the other player channel and the current player who make the check have js render the XO board.
- Most of actions and scenarios are covered with tests.
- ActionCable tested on the browser.

## install
```
clone the project
rake db:create
rake db:migrate
redis-server
rails s
```
