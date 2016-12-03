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

  describe "POST :create" do
    it "should create game and redirect to :show" do
      post :create
      expect(Game.count).to eq(1)
      expect(response).to redirect_to game_path(Game.last)
    end

    it "should have players" do
      post :create
      game = Game.last
      expect(game.players).to_not eq(0)
      expect(game.players).to include(Player.last)
    end
  end
end
