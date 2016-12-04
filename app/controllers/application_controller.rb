class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_player
    redirect_to login_players_path unless current_player
  end

  private

  def current_player
    if session[:player_id]
      Player.find { |p| p.id == session[:player_id] }
    else
      false
    end
  end

  helper_method :current_player
end
