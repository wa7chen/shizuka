class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :mood
      t.text :things
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
