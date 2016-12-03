class Game < ApplicationRecord
  include BoardScanner

  serialize :statistics
  enum status: [:pending, :in_porgress, :finished]

  has_many :round_players
  has_many :players, through: :round_players, foreign_key: :game_id
end
