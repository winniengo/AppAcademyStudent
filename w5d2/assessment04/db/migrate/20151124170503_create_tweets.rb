class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :tweets, :user_id
  end
end
