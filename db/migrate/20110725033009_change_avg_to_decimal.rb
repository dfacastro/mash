class ChangeAvgToDecimal < ActiveRecord::Migration
  def up
    change_column :musics, :average, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
