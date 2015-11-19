class CreateAlbum < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    	t.string :album_name, null: false
    	t.string :status, null: false
    	t.integer :band_id, null: false

    	t.timestamps null: false
    end

    add_index :albums, :band_id
  end
end
