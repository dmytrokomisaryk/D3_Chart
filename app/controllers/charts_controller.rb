require 'csv_parser'
class ChartsController < ApplicationController
  def index
    csv = CsvParser.new('session_history')

    @statistic = csv.json
    respond_to { |format| format.html }
  end
end
