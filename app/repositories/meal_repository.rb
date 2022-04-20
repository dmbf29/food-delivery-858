require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1 # starting point for our IDs
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def find(id)
    @meals.find do |meal|
      meal.id == id
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # 1. convert string values into it's real data type
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      # 2. create an instance
      meal = Meal.new(row)
      # 3. store the instance in the array
      @meals << meal
    end
    @next_id = @meals.any? ? @meals.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # add the HEADERS
      # csv << ['id', 'name', 'price']
      csv << Meal.headers
      # shovel each meal instance
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
