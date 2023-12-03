# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'random_recipes scope' do
    context 'when having more than 15 recipes' do
      let!(:recipe) { create_list(:recipe, 50) }
      let(:random_recipes) { Recipe.random_recipes }

      it 'returns 15 random recipes' do
        expect(random_recipes.count).to eq(15)
      end

      it 'returns recipes in a random order' do
        first_call = random_recipes
        second_call = random_recipes

        expect(first_call.pluck(:id)).not_to eq(second_call.pluck(:id))
      end
    end
  end
end
