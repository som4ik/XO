class GamesController < ApplicationController

  before_action :authenticate_player
  before_action :set_game, only: [:show, :join]
  before_action :is_game_player, only: [:show]

  def index
  end

  def show
  end

  def join
    return root_path if !@game.accept_player current_player
    @game.update(status: 1)
    redirect_to game_path(id: @game.id)
  end

  def create
    @game = Game.create
    @game.accept_player current_player
    redirect_to game_path(id: @game.id)
  end

  def click

  end

  private

  def set_game
    @game = Game.find(params[:id])
    session[:game_id] = @game.id if @game # for ActionCable connection
  end

  def is_game_player
    return true if @game.players.include?(current_player)
    redirect_to root_path
  end
end
