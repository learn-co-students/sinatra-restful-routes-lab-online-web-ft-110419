class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do 
  	@recipes = Recipe.all
  	erb :index
  end

  post '/recipes' do 
  	recipe = Recipe.create(params)
  	redirect "recipes/#{recipe.id}"
  end

  get '/recipes/new' do 
  	@recipes = Recipe.all
  	erb :new
  end

  post '/recipes/new' do
  	@recipe = Recipe.create(params)
  	redirect "recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do 
  	@recipe = Recipe.find(params[:id])
  	erb :show
  end

  patch '/recipes/:id' do 
  	@recipe = Recipe.find(params[:id])
  	if params[:name].length > 0
  		@recipe.name = params[:name]
  	end
  	if params[:ingredients].length > 0 
  		@recipe.ingredients = params[:ingredients]
  	end 
  	if params[:cook_time].length > 0
  		@recipe.cook_time = params[:cook_time]
  	end
  	@recipe.save
  	erb :show
  end

  delete '/recipes/:id' do 
  	recipe = Recipe.find(params[:id])
  	recipe.destroy
  	redirect '/recipes'
  end

  get '/recipes/:id/edit' do 
  	@recipe = Recipe.find(params[:id])
  	erb :edit
  end


end
