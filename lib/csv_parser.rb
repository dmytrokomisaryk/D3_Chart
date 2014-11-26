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


  def by_key(key)
    @data = @data.select{ |item| item[key].to_i > 0 }.sort_by {|item| item[key].to_i}.reverse
    self
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