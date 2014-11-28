require 'csv'

class CsvParser

  def initialize(file_name)
    @file_name = file_name
    parse
    self
  end

  def max_count(count)
    @limit = count
    self
  end

  def paginate(from_index)
    check_previous_and_next_data(from_index)
    @data = @data[from_index..(from_index + limit - 1)].reverse
    self
  end

  def json
    @data.to_json
  end

  def by_key(key)
    return self if key.blank?
    @data = @data.select{ |item| item[key].to_i > 0 }.sort_by {|item| item[key].to_i}
    self
  end

  def has_previous?
    has_previous
  end

  def has_next?
    has_next
  end

  private
  attr_reader :file_name, :data, :limit, :has_previous, :has_next

  def parse
    csv = CSV.open(file_path, headers: true)
    @data = csv.map { |row| row.to_h }
  end

  def file_path
    File.join(Rails.root, 'statistic_data', "#{file_name}.csv")
  end

  def check_previous_and_next_data(index)
    next_index = index - 1
    previous_index = index + limit + 1

    @has_previous = @data[previous_index].present?
    @has_next = next_index >= 0
  end
end