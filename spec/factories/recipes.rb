# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    cook_time { Faker::Number.within(range: 10..100) }
    prep_time { Faker::Number.within(range: 10..100) }
    ingredients { %w[milk eggs bread sugar] }
    ratings { Faker::Number.within(range: 1..5) }
    cuisine { Faker::Food.ethnic_category }
    author { Faker::Name.name }
  end
end
