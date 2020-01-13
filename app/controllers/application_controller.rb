class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do # contains all of the recipes + link to new recipe form. - This passes.
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do # contains form for a new recipe. - This passes.
    erb :form
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do # Shows recipe by its id.
    @user_recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @edit = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do # edits a recipe based on its id.
    @editing = Recipe.find_by_id(params[:id])
    @editing.name = params[:name]
    @editing.ingredients = params[:ingredients]
    @editing.cook_time = params[:cook_time]
    @editing.save
    redirect to "/recipes/#{@editing.id}"
  end

  delete '/recipes/:id' do # deletes recipe by its id.
    @deletion = Recipe.find_by_id(params[:id])
    @deletion.delete
    redirect '/recipes'
  end

end
