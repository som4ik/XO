require 'rails_helper'
shared_examples_for "board_scanner" do
  let(:model) { Game }
  before :each do
    @game = FactoryGirl.create :game
    p1 = FactoryGirl.create(:player)
    p2 = FactoryGirl.create(:player)
    @game.round_players.create(player_id: p1.id, mark: "X")
    @game.round_players.create(player_id: p2.id, mark: "O")
  end

  it "should return win" do
    @game.statistics = { 1=>{1=>"O", 2=>"X", 3=>"O"},
                         2=>{1=>"O", 2=>"X", 3=>"X"},
                         3=>{1=>"", 2=>"X", 3=>""}
                        }
    @game.save
    expect(@game.update_and_scan_board("1:2","X")).to eq('win')
    expect(@game.winner_name).to eq(@game.round_players.find_by(mark: "X").player.name)
  end

  it "should return no one" do
    @game.statistics = { 1=>{1=>"O", 2=>"X", 3=>"O"},
                         2=>{1=>"X", 2=>"X", 3=>"O"},
                         3=>{1=>"O", 2=>"O", 3=>"X"}
                        }
    @game.save
    expect(@game.update_and_scan_board("1:2", "X")).to eq('no one')
  end

  it "should return next" do
    @game.statistics = { 1=>{1=>"O", 2=>"X", 3=>"O"},
                         2=>{1=>"X", 2=>"", 3=>"O"},
                         3=>{1=>"O", 2=>"O", 3=>"X"}
                        }
    @game.save
    expect(@game.update_and_scan_board("1:2", "X")).to eq('next')
  end
end
