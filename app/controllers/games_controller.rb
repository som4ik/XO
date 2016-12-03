class GamesController < ApplicationController
  before_action :authenticate_player
  before_action :set_game, only: [:show, :join]

  def index
  end

  def show
  end

  def join

  end

  def create
    @game = Game.create
    @game.players << current_player
    @game.save
    redirect_to game_path(id: @game.id)
  end

  private

  def set_game
    @game = Game.find(params[:id])
    session[:game_id] = @game.id if @game # for ActionCable connection
  end
end
