class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # INSTANCE of a meal
    @customer = attributes[:customer] # INSTANCE of a customer
    @employee = attributes[:employee] # INSTANCE of a employee (rider)
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  # only the rider trigger things as delivered
  def deliver!
    @delivered = true
  end

  def self.headers
    ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
  end
end
