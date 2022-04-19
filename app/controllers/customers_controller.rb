require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get all the customers from the repository
    customers = @customer_repository.all
    # give the customers to the view to display
    @customers_view.display(customers)
  end

  def add
    # ask user for name
    name = @customers_view.ask_for('name')
    # ask user for address
    address = @customers_view.ask_for('address')
    # create the instance
    customer = Customer.new(
      name: name,
      address: address
    )
    # give to the repository
    @customer_repository.create(customer)
  end
end
