# frozen_string_literal: true

set :views, "#{__dir__}/views"

get '/' do
  recipes = Recipe.all_recipes

  erb :index, locals: { recipes: recipes }
end

get '/:id' do
  recipe = Recipe.find(params[:id])

  erb :show, locals: { recipe: recipe }
end
