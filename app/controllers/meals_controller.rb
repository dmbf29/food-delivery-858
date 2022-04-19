require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # get all the meals from the repository
    meals = @meal_repository.all
    # give the meals to the view to display
    @meals_view.display(meals)
  end

  def add
    # ask user for name
    name = @meals_view.ask_for('name')
    # ask user for price
    price = @meals_view.ask_for('price').to_i
    # create the instance
    meal = Meal.new(
      name: name,
      price: price
    )
    # give to the repository
    @meal_repository.create(meal)
  end
end
