require 'rails_helper'

feature "Player" do
  context "As not Auth player" do
    let!(:player) {FactoryGirl.create(:player) }
    scenario "can visit home page" do
      visit '/'
      expect(page.body).to have_content('Welcome to XO enter your name here')
    end

    scenario "can login by enter the name " do
      visit '/'
      fill_in :player_name, with: player.name
      click_on('GO')
      expect(page.body).to have_content('Refresh')
      expect(page.get_rack_session["player_id"]).to eq(player.id)
    end

  end

  context "As Auth player" do
    let!(:player) {FactoryGirl.create(:player)}
    scenario "can create new game" do
      page.set_rack_session(player_id: player.id)
      visit '/'
      click_on('Start New Game')
      expect(page.body).to have_content('Waiting for other player to join')
    end

    scenario "as game owner can enter it" do
      game = player.games.create
      page.set_rack_session(player_id: player.id)
      visit '/'
      click_on('Back to Game')
      expect(page.body).to have_content('Waiting for other player to join')
    end

    scenario "can join other players pending games" do
      player_2 = FactoryGirl.create(:player)
      game = player.games.create
      page.set_rack_session(player_id: player_2.id)
      visit '/'
      click_on('Join now')
      expect(page.body).to have_content('Be the first who start')
      expect(game.players.count).to eq(2)

    end

    scenario "another user can't join full game that in porgress" do
      game = player.games.create
      player_2 = FactoryGirl.create(:player)
      game.round_players.create(player_id: player_2.id)
      game.status = 1
      game.save
      player_3 = FactoryGirl.create :player
      page.set_rack_session(player_id: player_3.id)
      visit "/"
      expect(page.current_path).to eq('/')
      expect(page.body).to have_content('Game in porgress player_16 vs. player_17')
    end

    scenario "can logout" do
      page.set_rack_session(player_id: player.id)
      visit '/'
      click_on("#{player.name}, Go with Other account")
      expect(page.body).to have_content('Welcome to XO enter your name here')
    end
  end
end
