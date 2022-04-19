require 'csv'
require_relative '../models/customer'

class CustomerRepository < BaseRepository

  def build_element(row)
    row[:id] = row[:id].to_i
    # 2. create an instance
    Customer.new(row)
  end
end
