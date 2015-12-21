class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :benches, :desription, :description
  end
end
