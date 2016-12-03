module Auth
  def auth(player)
    session[:player_id] = player.id
  end
end
