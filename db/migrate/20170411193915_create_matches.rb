class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :players, array: true
      t.integer :max_players
    end
  end
end
