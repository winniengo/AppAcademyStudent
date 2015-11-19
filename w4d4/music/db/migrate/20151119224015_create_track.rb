class CreateTrack < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
    	t.text :lyrics
    	t.string :track_name, null: false
    	t.string :status, null: false
    	t.integer :album_id, null: false

    	t.timestamps null: false
    end

    add_index :tracks, :album_id
  end
end
