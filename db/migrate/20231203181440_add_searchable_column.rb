# frozen_string_literal: true

class AddSearchableColumn < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE recipes
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(ingredients::text, ''))
      ) STORED;
    SQL
  end

  def down
    remove_column :recipes, :searchable
  end
end
