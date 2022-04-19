class CustomersView < BaseView
  def display(customers) # an array of INSTANCES
    if customers.any?
      customers.each_with_index do |customer, index|
        puts "#{index + 1} - #{customer.name.capitalize} - #{customer.address}"
      end
    else
      puts "No customers yet 🙆"
    end
  end
end
