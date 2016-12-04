class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel_#{current_game.id}_#{current_player.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
