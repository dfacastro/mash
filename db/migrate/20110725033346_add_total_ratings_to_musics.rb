class AddTotalRatingsToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :total_ratings, :integer
  end
end
