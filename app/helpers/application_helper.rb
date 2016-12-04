module ApplicationHelper
  def show_status(game)
    s = case game.status
          when 'pending'
            'Waiting for other player to join'
          when 'in_porgress'
            (current_player.your_turn(game) || !game.turn) ? 'Be the first who start' : "Waiting for other player"
          when 'finished'
            if game.winner.present?
              return "This game is finished, You won" if game.winner == current_player.id
              return "This game is finished, #{game.winner_name} wins" if game.winner != current_player.id
            else
              return "This game is over No One wins"
            end
          end
    return s
  end

  def current_player_game(game)
    game.players.include?(current_player)
  end

  def board_btn(game, r, c)
    st = game.statistics
    if game.statistics.present? && game.statistics[r][c].present?
      button_to st[r][c], click_games_path(id: game.id), class: 'btn xo btn-default', disabled: true, id: "#{r.to_s + c.to_s}", remote: true
    else
      button_to '', click_games_path(id: game.id, position: "#{r.to_s + ':' + c.to_s}"), class: 'btn xo btn-default', id: "#{r.to_s + c.to_s}", remote: true, disabled: ((current_player.your_turn(game) || !game.turn)&& !game.finished? && game.is_full?) ? false : true
    end
  end
end
