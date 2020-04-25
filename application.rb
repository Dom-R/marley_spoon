# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

require './initializers/contentful_model.rb'
require './models/recipe.rb'

get '/' do
  recipes = Recipe.all_recipes

  erb :index, locals: { recipes: recipes }
end
