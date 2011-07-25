class AddAverageToMusic < ActiveRecord::Migration
  def change
    add_column :musics, :average, :integer
  end
end
