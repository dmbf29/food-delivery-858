class Employee
  attr_reader :username, :password

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @username = attributes[:username] # string
    @password = attributes[:password] # string
    @role = attributes[:role] # string
  end

  def manager?
    @role == 'manager'
  end

  def rider?
    @role == 'rider'
  end

end