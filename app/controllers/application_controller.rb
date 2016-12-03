class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_player
    redirect_to login_players_path unless current_player
  end

  def current_player
    if session[:player_id]
      Player.find { |p| p.id == session[:player_id] }
      true
    else
      false
    end
  end
end
