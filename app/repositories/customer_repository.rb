require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1 # starting point for our IDs
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # 1. convert string values into it's real data type
      row[:id] = row[:id].to_i
      # 2. create an instance
      customer = Customer.new(row)
      # 3. store the instance in the array
      @customers << customer
    end
    @next_id = @customers.any? ? @customers.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # add the HEADERS
      # csv << ['id', 'name', 'address']
      csv << Customer.headers
      # shovel each customer instance
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
