class GamesController < ApplicationController

  before_action :authenticate_player
  before_action :set_game, only: [:show, :join, :click]
  before_action :is_game_player, only: [:show]
  before_action :set_game_cookies, only: [:show, :join]

  def index
    @games = Game.on_going
  end

  def show
  end

  def join
    if !@game.accept_player current_player
      redirect_to root_path
    else
      @game.update(status: 1)
      @game.notify_by_join(@game.now_waiting_player current_player)
      redirect_to game_path(id: @game.id)
    end
  end

  def create
    @game = current_player.games.create
    redirect_to game_path(id: @game.id)
  end

  def click
    respond_to do |format|
      format.js do
        @now_playing = @game.now_playing_player current_player
        @other_waiting = @game.now_waiting_player current_player
        first_click(@game, @now_playing, @other_waiting)
        @game.toggle_players(@other_waiting)
        @check_status = @game.update_and_scan_board(params[:position], @now_playing.mark)
        @game.notify_by_status(@check_status, @now_playing, @other_waiting, params[:position])
      end
    end
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

  def first_click(game, p1, p2)
    if !game.turn.present?
      p1.update(mark: 'X')
      p2.update(mark: 'O')
    end
  end

  def set_game_cookies
    cookies[:game_id] = @game.id
    cookies[:player_id] = current_player.id if @game.players.include? current_player
  end
end
