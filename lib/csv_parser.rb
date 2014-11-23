require 'csv'

class CsvParser

  def initialize(file_name)
    @file_name = file_name
    parse
    self
  end

  def quota(count)
    @limit = count
    self
  end

  def paginate(from_index)
    @data = @data[from_index..(from_index + limit)]
    self
  end

  def json
    @data.to_json
  end

  private
  attr_reader :file_name, :data, :limit

  def parse
    csv = CSV.open(file_path, headers: true)
    @data = csv.map { |row| row.to_h }
  end

  def file_path
    File.join(Rails.root, 'statistic_data', "#{file_name}.csv")
  end
end