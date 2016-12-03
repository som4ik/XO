class Game < ApplicationRecord
  include BoardScanner

  serialize :statistics
  enum status: [:pending, :in_porgress, :finished]

  has_many :round_players
  has_many :players, through: :round_players, foreign_key: :game_id

  def is_full?
    players.count == 2
  end

  def accept_player(player)
    players << player
    self.save
  end
end
