require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "Player validation" do
    it "has valid factory" do
      player = FactoryGirl.create(:player)
      expect(player).to be_valid
    end
    it { should validate_presence_of(:name) }
  end
end
