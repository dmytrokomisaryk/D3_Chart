require 'csv'

class CsvParser

  def initialize(file_name)
    @file_name = file_name
    read
    self
  end

  def json
    @data.map { |row| row.to_h }.to_json
  end

  private
  attr_reader :file_name, :data

  def file_path
    File.join(Rails.root, 'statistic_data', "#{file_name}.csv")
  end

  def read
    @data = CSV.open(file_path, headers: true)
  end
end