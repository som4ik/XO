class Player < ApplicationRecord
  validates :name, presence: true

  has_many :round_players, dependent: :destroy
  has_many :games, through: :round_players, foreign_key: :player_id, dependent: :destroy

  def your_turn(game)
    return true if self.id == game.turn
    false
  end

  def mark(game)
    round_players.find_by(player_id: self.id, game_id: game.id).mark
  end
end
