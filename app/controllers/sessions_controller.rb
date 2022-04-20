require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # username = ask user for username
    username = @sessions_view.ask_for('username')
    # password = ask user for password
    password = @sessions_view.ask_for('password')
    # employee = ask the repository for a employee with the given username (instance or nil)
    employee = @employee_repository.find_by_username(username)
    # (if) check the password from the employee instance and compare to the given password
    if employee && employee.password == password
      @sessions_view.welcome_message(employee)
      return employee
    else
      @sessions_view.wrong_credentials
      login
    end
  end
end
