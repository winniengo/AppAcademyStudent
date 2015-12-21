class AddUniqueness < ActiveRecord::Migration
  def change
    add_index :benches, [:lat, :lng], unique: true
  end
end
