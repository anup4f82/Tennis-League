class CreateMessages < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
  	 t.belongs_to :user
  	 t.string :message
  	 t.boolean :playing
     t.integer :contact_user_id
     t.datetime :time_proposed
    end
     
  end
end
