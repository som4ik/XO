class GamesController < ApplicationController
  before_action :authenticate_player
  def show
    @game = Game.find(params[:id])
  end

  def index

  end
end
