require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    let!(:player) { FactoryGirl.create :player }

  before :each do
    session[:player_id] = player.id
  end

  describe "GET :show method" do
    it "should render show template" do
      game = FactoryGirl.create(:game, status: 0)
      game.players << player
      game.save
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
      expect(game.players).to include(player)
    end
  end

  describe "GET :join" do
    let!(:game)  {FactoryGirl.create(:game, status: 0)}

    before :each do
      player = FactoryGirl.create(:player)
      game.players << Player.last
      get :join, params: {id: game}
    end

    it "should add player to players" do
      expect(game.players.count).to eq(2)
    end
  end

  describe "POST :click" do
    before :each do
      @game = Game.create(status: 0, winner: nil, turn: nil)
      @p1 = FactoryGirl.create(:player)
      @p2 = FactoryGirl.create(:player)
      @game.round_players.create(player_id: @p1.id)
      @game.round_players.create(player_id: @p2.id)
    end

    it "sould give response 200" do
      @game.statistics = { 1=>{1=>"O", 2=>"", 3=>"O"},
                          2=>{1=>"O", 2=>"X", 3=>"X"},
                          3=>{1=>"", 2=>"X", 3=>""}
                        }
      session[:player_id] = @p1.id
      post :click, params: { position: "1:2", id: @game.id}, xhr: true
      expect(response.code).to eq('200')
    end
  end
end
