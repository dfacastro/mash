class AddUseridToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :user_id, :integer
  end
end
