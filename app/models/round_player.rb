class RoundPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :player_id, :game_id, presence: true
  validates :player_id, uniqueness: { scope: :game_id }
  validate :game_players_count

  def game_players_count
    errors.add(:base, "Players count can't be more that 2") if RoundPlayer.where(game_id: self.game_id).count > 2
  end
end
