# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = get_recipes_by_ingredients(params[:query])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def get_recipes_by_ingredients(query_param)
    if query_param.present?
      @recipes = Recipe.search_by_ingredients(params[:query]).limit(16)
    else
      Recipe.random_recipes
    end
  end
end
