require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = orders_csv_path
    @orders = []
    @next_id = 1 # starting point for our IDs
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def find(id)
    @orders.find do |order|
      order.id == id
    end
  end

  def mark_as_delivered(order)
    # mark the instance as delivered
    order.deliver!
    # save to csv
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # 1. convert string values into it's real data type
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal_id] = row[:meal_id].to_i
      meal = @meal_repository.find(row[:meal_id])
      row[:meal] = meal
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      # # 2. create an instance
      order = Order.new(row)
      # # 3. store the instance in the array
      @orders << order
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # add the HEADERS
      csv << Order.headers
      # shovel each order instance
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end
