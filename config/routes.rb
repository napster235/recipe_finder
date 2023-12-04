# frozen_string_literal: true

Rails.application.routes.draw do
  resources :recipes, only: %i[index show] do
    get '/recipe/:recipe', action: :index, on: :collection
  end

  root 'recipes#index'
end
