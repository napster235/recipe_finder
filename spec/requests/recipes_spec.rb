# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes', type: :request do
  describe 'GET #index' do
    context 'when on index page' do
      let(:recipe) { create(:recipe) }
      subject { get recipes_path }

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #show' do
    context 'when on show page' do
      let(:recipe) { create(:recipe) }
      subject { recipe_path(recipe) }

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end
    end
  end
end
