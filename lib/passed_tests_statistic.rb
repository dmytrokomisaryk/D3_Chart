require 'csv'

class PassedTestsStatistic

  def initialize(file_name)
    @file_name = file_name
    load_data
    prepare_periods
    self
  end

  def all
    existing_statuses.map { |status| prepare_statistic_in_hash(status) }.compact
  end

  private
  attr_reader :file_name, :data, :periods

  def prepare_statistic_in_hash(status)
    data = parse_data(status)
    return if data.blank?
    {'key' => status, 'values' => data}
  end

  def load_data
    csv = CSV.open(file_path, headers: true)
    @data = csv.map { |row| row.to_hash }.reverse
  end

  def prepare_periods
    @periods = @data.map { |session| date_to_integer(session['created_at']) }
  end

  def file_path
    File.join(Rails.root, 'statistic_data', "#{file_name}.csv")
  end

  def existing_statuses
    @data.group_by { |item| item['summary_status'] }.keys
  end

  def parse_data(status)
    periods_with_tests_count = periods.map { |period| [period, 0] }

    periods_with_tests_count.each do |period|
      @data.each do |session|
        return unless eval("session['#{status}_tests_count']")
        next unless period[0] == date_to_integer(session['created_at'])
        period[1] = eval("session['#{status}_tests_count']").to_i
      end
    end

    periods_with_tests_count
  end

  def date_to_integer(date)
    "#{date.to_time.to_i}000".to_i
  end
end