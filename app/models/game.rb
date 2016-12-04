class Game < ApplicationRecord
  include BoardScanner
  include Notifyer

  serialize :statistics
  enum status: {pending: 0, in_porgress: 1, finished: 2}

  scope :on_going, -> { where.not(status: 2).order(created_at: :desc)}

  before_create :set_statisitics

  has_many :round_players, dependent: :destroy
  has_many :players, through: :round_players, foreign_key: :game_id, dependent: :destroy

  validate :max_players_count

  def is_full?
    players.count == 2
  end

  def winner_name
    players.find_by(id: winner).name
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

  def toggle_players(player)
    self.update(turn: player.player_id)
  end

  def now_playing_player(player)
    self.round_players.find_by(player_id: player.id)
  end

  def now_waiting_player(player)
    self.round_players.where.not(player_id: player.id).last
  end
end
