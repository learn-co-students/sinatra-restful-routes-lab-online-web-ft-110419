class CreateRecipes < ActiveRecord::Migration
  def change
  	create_table :recipes do |tb|
  		tb.string :name 
  		tb.string :ingredients 
  		tb.float :cook_time
  	end
  end
end
