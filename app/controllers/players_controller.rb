class PlayersController < ApplicationController
  def login
    @player = Player.new
  end

  def create
    @player = Player.find_or_create_by player_params
    if @player
      session[:player_id] = @player.id
      redirect_to root_path
    else
      redirect_to login_players_path
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
