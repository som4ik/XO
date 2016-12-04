module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_game, :current_player

    def connect
      self.current_game = find_verified[0]
      self.current_player = find_verified[1]
    end

    protected

    def find_verified
      current_game = Game.find_by(id: cookies[:game_id])
      current_player = Player.find_by(id: cookies[:player_id])
      if current_game && current_player
        [current_game, current_player]
      else
        reject_unauthorized_connection
      end
    end
  end
end
