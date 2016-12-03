require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  before :each do
    player = FactoryGirl.create :player
    session[:player_id] = player.id
  end
  describe "GET :show method" do
    it "should render show template" do
      game = FactoryGirl.create(:game, status: 0)
      get :show, params: {id: game.id}
      expect(response.code).to eq('200')
      expect(response).to render_template(:show)
    end
  end

  describe "GET :index" do
    it "should render index template" do
      get :index
      expect(response.code).to eq('200')
      expect(response).to render_template(:index)
    end
  end
end
