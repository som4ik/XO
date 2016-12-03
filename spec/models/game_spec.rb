require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "vaild game elements " do

    it { should define_enum_for(:status) }
    it { should serialize(:statistics) }

    it "should have valid factory" do
      game = FactoryGirl.create(:game)
      expect(game).to be_valid
    end
  end
end
