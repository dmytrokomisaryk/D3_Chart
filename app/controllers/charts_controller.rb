require 'csv_parser'
class ChartsController < ApplicationController
  def index
    csv = CsvParser.new('session_history')
    @statistic = csv.quota(35).paginate(1).json
    respond_to { |format| format.html }
  end
end
