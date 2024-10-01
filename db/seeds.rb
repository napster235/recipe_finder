# frozen_string_literal: true

directory = File.dirname(__FILE__)
file_location = File.join(directory, 'output_recipes.json')
recipe_list = JSON.parse(File.read(file_location))

Recipe.insert_all(recipe_list)
