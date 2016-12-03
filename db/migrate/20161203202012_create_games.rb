class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :status, default: 0
      t.integer :winner
      t.string :statistics

      t.timestamps
    end
  end
end
