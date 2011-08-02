class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :user_id
      t.integer :music_id
      t.integer :ip

      t.timestamps
    end
  end
end
