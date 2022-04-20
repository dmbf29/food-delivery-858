class SessionsView < BaseView
  def welcome_message(employee)
    puts "Welcome #{employee.username}"
  end

  def wrong_credentials
    puts "Wrong username or password. Try again."
  end
end
