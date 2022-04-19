require 'csv'
require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository

  private

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:price].to_i
    # 2. create an instance
    Meal.new(row)
  end
end
