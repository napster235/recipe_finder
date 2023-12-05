# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes', type: :request do

  describe 'GET #index' do
    context 'when on index page' do
      let!(:recipe) { create_list(:recipe, 20) }
      subject { get recipes_path }

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'renders the index view' do
        subject
        expect(response).to render_template(:index)
      end

      it 'does not have empty body' do
        subject
        expect(response.body).not_to be_nil
      end
    end

    context 'when on index page with no recipes' do
      subject { get recipes_path }

      it 'renders a specific message' do
        subject
        expect(response.body).to include('No recipes found')
      end
    end

    context 'when ordering' do
      let!(:recipe1) { create(:recipe, ratings: 1.0, ingredients: 'eggs, milk, salad') }
      let!(:recipe2) { create(:recipe, ratings: 2.0, ingredients: 'eggs, cheese, chicken') }
      let!(:recipe3) { create(:recipe, ratings: 3.0, ingredients: 'tuna, milk, cereals') }
      let(:ordered_recipes) { assigns(:recipes) }

      context 'by ratings in descending order' do
        subject { get recipes_path, params: { order: 'DESC' } }

        it 'orders the recipes by rating from high to low' do
          subject

          expect(ordered_recipes).to eq([recipe3, recipe2, recipe1])
        end
      end

      context 'by ratings in ascending order' do
        subject { get recipes_path, params: { order: 'ASC' } }

        it 'orders the recipes by rating from low to high' do
          subject

          expect(ordered_recipes).to eq([recipe1, recipe2, recipe3])
        end
      end

      context 'by ratings descending and searching by ingredient' do
        subject { get recipes_path, params: { order: 'DESC', query: 'eggs' } }

        it 'orders the recipes by rating from high to low' do
          subject

          expect(ordered_recipes).to eq([recipe2, recipe1])
        end
      end

      context 'by ratings ascending and searching by ingredient' do
        subject { get recipes_path, params: { order: 'ASC', query: 'eggs' } }

        it 'orders the recipes by rating from low to high' do
          subject

          expect(ordered_recipes).to eq([recipe1, recipe2])
        end
      end

      context 'when on index page, default order is DESC' do
        subject { get recipes_path }

        it 'always displays recipes by descending rating' do
          subject

          expect(ordered_recipes).to eq([recipe3, recipe2, recipe1])
        end
      end
    end
  end

  describe 'GET #show' do
    context 'when on show page' do
      let!(:recipe) { create(:recipe) }
      subject { get recipe_path(recipe) }

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'renders the show view' do
        subject
        expect(response).to render_template(:show)
      end

      it 'does not have empty body' do
        subject
        expect(response.body).not_to be_nil
      end
    end
  end
end
