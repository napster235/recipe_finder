# frozen_string_literal: true

class Recipe < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_ingredients, against: :ingredients,
                  using: {
                    tsearch: {
                      dictionary: 'english',
                      tsvector_column: 'searchable'
                    }
                  }

  scope :random_recipes, -> { order('RANDOM()').limit(15) }
end
