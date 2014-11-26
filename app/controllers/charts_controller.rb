require 'csv_parser'

class ChartsController < ApplicationController
  def index
    @statistic = current_csv.quota(30).paginate(1).json
    respond_to { |format| format.html }
  end

  def slide
    render json: { data: current_csv.quota(30).paginate(params[:index].to_i).json }
  end

  def filter
    render json: { data: current_csv.by_key(params[:key]).quota(30).paginate(1).json }
  end

  private

  def current_csv
    CsvParser.new('session_history')
  end
end
