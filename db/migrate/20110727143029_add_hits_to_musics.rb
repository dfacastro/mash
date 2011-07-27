class AddHitsToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :hits, :integer, :default => 0

    Music.all.each do |m|
      m.hits = 0
      m.save
    end
  end
end
