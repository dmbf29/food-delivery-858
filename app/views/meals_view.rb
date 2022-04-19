require_relative 'base_view'

class MealsView < BaseView
  def display(meals) # an array of INSTANCES
    if meals.any?
      meals.each_with_index do |meal, index|
        puts "#{index + 1} - #{meal.name.capitalize} - ¥#{meal.price}"
      end
    else
      puts "No meals yet 🍽"
    end
  end
end
