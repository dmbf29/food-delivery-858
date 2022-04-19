class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = 1 # starting point for our IDs
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @elements
  end

  def create(element)
    element.id = @next_id
    @next_id += 1
    @elements << element
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # add the HEADERS
      # csv << ['id', 'name', 'price']

      csv << @elements.first.class.headers
      # shovel each meal instance
      @elements.each do |element|
        csv << element.build_row
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      element = build_element(row) # return an instance
      @elements << element
    end
    @next_id = @elements.any? ? @elements.last.id + 1 : 1
  end
end
