require_relative '../views/employees_view'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    # ask the order repo for undelivered orders
    orders = @order_repository.undelivered_orders
    # give the view the orders
    @orders_view.display(orders)
  end

  def add
    # get meals from the meal_repo
    # give those meals to the view to display
    # ask user to choose a number (index) for the meal
    # get the one meal from the meals array
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    meal = meals[index]

    # get customers from the customer_repo
    # give those customers to the view to display
    # ask user to choose a number (index) for the customer
    # get the one customer from the customers array
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    customer = customers[index]

    # get riders from the employee_repo
    # give those riders to the view to display
    # ask user to choose a number (index) for the employee
    # get the one rider from the riders array
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    employee = employees[index]

    # Create an instance of an order (meal, customer, rider)
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # give to repository
    @order_repository.create(order)
  end

  def list_my_orders(employee)
    display_my_orders(employee)
  end

  def mark_as_delivered(employee)
    # display my undelivered orders
    display_my_orders(employee)
    # index = ask user which one
    index = @orders_view.ask_for('number').to_i - 1
    orders = @order_repository.my_undelivered_orders(employee)
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end

  private

  def display_my_orders(employee)
    # ask the order repo for my orders
    orders = @order_repository.my_undelivered_orders(employee)
    # give the orders to the view
    @orders_view.display(orders)
  end

end
