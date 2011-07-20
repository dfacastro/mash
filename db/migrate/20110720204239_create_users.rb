class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.string :name
      t.date :birthdate
      t.string :city
      t.string :country
      t.string :occupation

      t.timestamps
    end
  end
end
