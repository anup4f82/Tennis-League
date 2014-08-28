class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :rating
      t.string :location
      t.string :day
      t.string :player
      t.string :shot
      t.string :leagueno
      t.integer :noofwins
      t.integer :noofmatches

 
      t.timestamps
    end
  end
end
