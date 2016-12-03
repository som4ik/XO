require 'rails_helper'

RSpec.describe RoundPlayer, type: :model do
  describe "validation check" do
    it "should have valid factory" do
      round_player = FactoryGirl.create(:round_player, mark: "X")
      expect(round_player).to be_valid
    end

    it "should have uniqness of scope" do
      game = FactoryGirl.create(:game)
      player = FactoryGirl.create(:player)
      FactoryGirl.create(:round_player, player_id: player.id, game_id: game.id, mark: "O")
      should validate_uniqueness_of(:player_id).scoped_to(:game_id)
    end
  end
end
