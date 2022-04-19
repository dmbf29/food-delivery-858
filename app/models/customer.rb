class Customer
  attr_reader :name, :address
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @name = attributes[:name] # string
    @address = attributes[:address] # string
  end

  # Customer.headers
  def self.headers
    ['id', 'name', 'address']
  end
end
