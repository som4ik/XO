class RoundPlayer < ApplicationRecord
  validates :player_id, :game_id, presence: true
  validates :player_id, uniqueness: { scope: :game_id }
  belongs_to :player
  belongs_to :game
end
