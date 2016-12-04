class Game < ApplicationRecord
  include BoardScanner

  serialize :statistics
  enum status: {pending: 0, in_porgress: 1, finished: 2}

  scope :on_going, -> { where.not(status: 2)}
  before_create :set_statisitics

  validate :max_players_count

  has_many :round_players
  has_many :players, through: :round_players, foreign_key: :game_id

  def is_full?
    players.count == 2
  end

  def accept_player(player)
    players << player
    self.save
  end

  def game_player?(player)
    players.include? player
  end

  def max_players_count
    errors.add(:base, "Players count can't be more that 2") if self.players.count > 2
  end

  def set_statisitics
    self.statistics = { 1=> {1=>"", 2=>"", 3=>""},
                        2=> {1=>"", 2=>"", 3=>""},
                        3=> {1=>"", 2=>"", 3=>""}
                      }
  end
end
