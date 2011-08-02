class ChangeDownloads < ActiveRecord::Migration
  def up
    change_column :downloads, :ip, :string
    remove_column :downloads, :user_id
  end

  def down
  end
end
