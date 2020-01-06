require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do 
    if Recipe.all.empty?
      redirect to '/recipes/new'
    else
      redirect '/recipes'
    end
  end
  
  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  post '/recipes' do
    Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time]).tap do |recipe|
      recipe.save
      redirect "/recipes/#{recipe.id}"
    end
  end
  
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end
  
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
  
  patch '/recipes/:id' do
    Recipe.find(params[:id]).tap do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
      )

      redirect "/recipes/#{recipe.id}"
    end
  end
  
  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    redirect to '/recipes'
  end

end
