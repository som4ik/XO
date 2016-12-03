class CreateRoundPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :round_players do |t|
      t.integer :player_id, foreign_key: true
      t.integer :game_id, foreign_key: true
      t.string :mark

      t.timestamps
    end
    add_index "round_players", ["player_id", "game_id"], :unique => true
  end
end
