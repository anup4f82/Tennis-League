class CreateScores < ActiveRecord::Migration
  def change
  	 create_table :scores do |t|
  	 
  	 t.string :content
  	 t.integer :winner_id
  	 t.integer :loser_id
  	 t.timestamps
    end
  end
end
