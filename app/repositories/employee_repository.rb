require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def all_riders
    @employees.select do |employee|
      employee.rider?
    end
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # 1. convert string values into it's real data type
      row[:id] = row[:id].to_i
      # 2. create an instance
      employee = Employee.new(row)
      # 3. store the instance in the array
      @employees << employee
    end
  end
end
