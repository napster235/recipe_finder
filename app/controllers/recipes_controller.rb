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
    ordered_recipes = Recipe.order(params[:order] == 'ASC' ? 'ratings ASC' : 'ratings DESC')

    if query_param.present?
      ordered_recipes.search_by_ingredients(params[:query]).page(params[:page])
    else
      ordered_recipes.random_recipes.page(params[:page])
    end
  end
end
