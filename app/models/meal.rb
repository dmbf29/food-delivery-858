class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @name = attributes[:name] # string
    @price = attributes[:price] # integer
  end

  def build_row
    [@id, @name, @price]
  end

  def self.headers
    ['id', 'name', 'price']
  end
end
