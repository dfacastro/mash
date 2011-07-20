class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :author
      t.text :description
      t.boolean :downloadable
      t.string :filename
      t.integer :length
      t.string :title

      t.timestamps
    end
  end
end
