require 'rails_helper'

RSpec.describe PlayersController, type: :controller do

  describe "GET :login" do
    it "it renders login page" do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe "POST :create" do
    it "redirect to root path after create player" do
      post :create, params: { player: {name: "player_1"} }
      expect(response).to redirect_to(root_path)
      expect(Player.first.name).to eq('player_1')
      expect(session[:player_id]).to eq(Player.first.id)
    end

    it "redirect t root_path after finding player" do
      player = FactoryGirl.create(:player, name: 'player name')
      post :create, params: {player: {name: 'player name'}}
      expect(response).to redirect_to root_path
      expect(session[:player_id]).to eq(player.id)
    end
  end
end
