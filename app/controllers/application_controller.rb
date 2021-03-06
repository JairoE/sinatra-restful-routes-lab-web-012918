class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes/new' do
    erb :new_recipe
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :recipes
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])

    erb :show_recipe
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    Recipe.update(params[:id], name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    recipe = Recipe.find_by_id(params[:id])

    redirect to "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete

    erb :delete
  end
end
