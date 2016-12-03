class Player < ApplicationRecord
  validates :name, presence: true

  has_many :round_players
  has_many :games, through: :round_players, foreign_key: :player_id
end
