class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :playlist_id
      t.integer :music_id
      t.integer :order_no

      t.timestamps
    end
  end
end
