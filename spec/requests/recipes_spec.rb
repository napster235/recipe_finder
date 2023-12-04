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
