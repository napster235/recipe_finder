# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '#random_recipes' do
    context 'when having more than 15 recipes' do
      let!(:recipe) { create_list(:recipe, 50) }
      let(:random_recipes) { Recipe.random_recipes }

      it 'returns recipes in a random order' do
        first_call = random_recipes
        second_call = random_recipes

        expect(first_call.pluck(:id)).not_to eq(second_call.pluck(:id))
      end
    end
  end

  describe '#search_by_ingredients' do
    context 'when searching by an included ingredient' do
      let!(:recipe1) { create(:recipe, ingredients: 'eggs, milk, salad') }
      let!(:recipe2) { create(:recipe, ingredients: 'fish, flour, lemon') }
      let!(:recipe3) { create(:recipe, ingredients: 'tuna, onion, lentil') }

      it 'returns recipes that match the search for the first recipe' do
        expect(query_results('eggs milk')).to include(recipe1)
      end

      it 'does not return the other recipes' do
        expect(query_results('fish, lentil')).not_to include(recipe2, recipe3)
      end

      it 'returns an empty array for no matches' do
        expect(query_results('water')).to be_empty
      end
    end
  end

  private

  def query_results(*query_params)
    Recipe.search_by_ingredients(query_params)
  end
end
