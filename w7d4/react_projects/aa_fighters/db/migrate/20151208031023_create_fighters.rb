class CreateFighters < ActiveRecord::Migration
  def change
    create_table :fighters do |t|
      t.string :name, null: false
      t.string :power, null: false
      t.text :history, null: false

      t.timestamps null: false
    end
  end
end
