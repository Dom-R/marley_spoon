# frozen_string_literal: true

require 'spec_helper'
require 'vcr_helper'

RSpec.describe Recipe do
  describe '.all_recipes', :vcr do
    it 'return all entities with content type recipe' do
      recipes = Recipe.all_recipes

      expect(recipes).to all be_a(Recipe)
      expect(recipes.map(&:id)).to match_array %w[2E8bc3VcJmA8OgmQsageas
                                                  437eO3ORCME46i02SeCW46
                                                  4dT8tcb6ukGSIg2YyuGEOm
                                                  5jy9hcMeEgQ4maKGqIOYW6]
    end
  end

  describe '.find', :vcr do
    context 'when entity exists' do
      it 'returns the recipe' do
        recipe = Recipe.find('2E8bc3VcJmA8OgmQsageas')

        expect(recipe).to be_a Recipe
        expect(recipe.title).to eq 'Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing'
      end
    end

    context 'when entity does not exist' do
      it 'returns nil' do
        recipe = Recipe.find('unknown_id')

        expect(recipe).to be_nil
      end
    end
  end

  describe '#tags_names', :vcr do
    context 'when recipe has tags' do
      it 'returns the tags names' do
        recipe = Recipe.find('437eO3ORCME46i02SeCW46')

        expect(recipe.tags_names).to eq 'gluten free, healthy'
      end
    end

    context 'when recipe does not have tags' do
      it 'returns nil' do
        recipe = Recipe.find('2E8bc3VcJmA8OgmQsageas')

        expect(recipe.tags_names).to be_nil
      end
    end
  end
end
