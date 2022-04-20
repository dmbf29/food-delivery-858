class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.login
      while @employee
        if @employee.manager?
          choice = display_manager_menu
          print `clear`
          manager_action(choice)
        else
          choice = display_rider_menu
          print `clear`
          rider_action(choice)
        end
      end
    end
  end

  private

  def display_manager_menu
    puts "---------------------------------------------"
    puts "------------ Le Wagon Restaurant ------------"
    puts "---------------------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "5 - Listing all undelivered orders"
    puts "6 - Add a order"
    puts "9 - Quit"
    puts "0 - Log out"
    print "> "
    gets.chomp.to_i
  end

  def display_rider_menu
    puts "---------------------------------------------"
    puts "------------ Le Wagon Restaurant ------------"
    puts "---------------------------------------------"
    puts "What do you want to do"
    puts "1 - List my orders"
    puts "2 - Mark order as delivered"
    puts "9 - Quit"
    puts "0 - Log out"
    print "> "
    gets.chomp.to_i
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 9 then quit
    when 0 then logout
    else
      puts "Try again..."
    end
  end

  def logout
    @employee = nil
  end

  def quit
    @employee = nil
    @running = false
  end

  def rider_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 9 then quit
    when 0 then logout
    else
      puts "Try again..."
    end
  end
end
