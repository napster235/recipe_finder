# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = get_recipes_by_ingredients(params[:query])
  end

  def show
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path
    flash[:alert] = "The recipe with id #{params[:id]} does not exist"
  end

  private

  def get_recipes_by_ingredients(query_param)
    ordered_recipes = Recipe.order(params[:order] == 'ASC' ? 'ratings ASC' : 'ratings DESC')

    recipes = if query_param.present?
                ordered_recipes.search_by_ingredients(params[:query])
              else
                ordered_recipes.random_recipes
              end

    recipes.page(params[:page])
  end
end
