class OrdersView < BaseView
  def display(orders) # an array of INSTANCES
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1} - #{order.meal.name} - Rider: #{order.employee.username} - 📍 #{order.customer.address}"
      end
    else
      puts "No orders yet 🙆"
    end
  end
end
