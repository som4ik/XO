module Notifyer
  def notify_by_status(check_status, current_player, other_player, cell)
    cell = cell.remove_double_dot
    case check_status
      when 'next'
        broad_cast_to_other(check_status, current_player, other_player, cell)
      else
        broad_cast_to_both(check_status, current_player, other_player, cell)
      end
  end

  def notify_by_join(player)
    ActionCable.server.broadcast "game_channel_#{self.id}_#{player.player_id}",
                                      content: 'Other player joined the game',
                                      command: 'joined'

  end

  private

  def broad_cast_to_both(check_status, current_player, other_player, cell)

    content = check_status.eql?('win') ? "win" : "No one Wins"
    ActionCable.server.broadcast "game_channel_#{self.id}_#{current_player.player_id}",
                                       content: content.eql?('win') ? 'You Win' : "No one Wins",
                                       command: check_status,
                                       cell: content.eql?('win') ? current_player.game.winner_cells(cell[0]+':'+cell[1], current_player.mark) : cell,
                                       val: current_player.mark

    ActionCable.server.broadcast "game_channel_#{self.id}_#{other_player.player_id}",
                                       content: content.eql?('win') ? 'You lose' : "No one Wins",
                                       command: check_status,
                                       cell: content.eql?('win') ? current_player.game.winner_cells(cell[0]+':'+cell[1], current_player.mark) : cell,
                                       val: current_player.mark

  end

  def broad_cast_to_other(check_status, current_player, other_player, cell)
    content = "#{current_player.player.name} Checked, Your turn"
    ActionCable.server.broadcast "game_channel_#{self.id}_#{other_player.player_id}",
                                       content: content,
                                       command: check_status,
                                       cell: cell,
                                       val: current_player.mark
  end

  def who_win?(player)
    self.winner == player.player_id
  end
end
