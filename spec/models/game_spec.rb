require 'rails_helper'

RSpec.describe Game, type: :model do
    let!(:game) {FactoryGirl.create :game}
    let!(:player_1) {FactoryGirl.create :player }
    let!(:player_2) {FactoryGirl.create :player }

  it_behaves_like "board_scanner"

  describe "vaild game elements " do

    it { should define_enum_for(:status) }
    it { should serialize(:statistics) }

    it "should have valid factory" do
      expect(game).to be_valid
    end

    it "should not have more than 2 players in round" do
      game.players << player_1 << player_2
      game.save
      game.players << FactoryGirl.create(:player)
      expect(game.valid?).to eq(false)
    end
  end

  describe "game full of players" do
    it "should return true on 2 players in" do
      game.players << player_1 << player_2
      game.save
      expect(game.is_full?).to eq(true)
    end

    it "should return false on 1 player in" do
      game.players << player_1
      game.save
      expect(game.is_full?).to eq(false)
    end
  end

  describe "accept player" do
    it "shoud accept player in crew" do
      game.accept_player(player_1)
      expect(game.players).to include(player_1)
    end
  end
end
