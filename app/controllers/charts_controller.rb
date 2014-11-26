require 'csv_parser'
class ChartsController < ApplicationController
  def index
    @statistic = current_csv.quota(35).paginate(1).json
    respond_to { |format| format.html }
  end

  def slide
    respond_to { |format| format.json { render json: current_csv.quota(35).paginate(params[:index].to_i).json } }
  end

  private

  def current_csv
    CsvParser.new('session_history')
  end
end
