class Game < ApplicationRecord
  serialize :statistics
  enum status: [:pending, :in_porgress, :finished]
end
