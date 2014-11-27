require 'csv_parser'

class ChartsController < ApplicationController
  LIMIT = 30

  def index
    @statistic = current_csv.max_count(LIMIT).paginate(0).json
    respond_to { |format| format.html }
  end

  def slide
    statistic = current_csv.by_key(params[:key]).max_count(LIMIT).paginate(params[:index].to_i)
    render json: prepare_json(statistic)
  end

  def filter
    statistic = current_csv.by_key(params[:key]).max_count(LIMIT).paginate(0)
    render json: prepare_json(statistic)
  end

  private

  def current_csv
    CsvParser.new('session_history')
  end

  def prepare_json(statistic)
    {
        data: statistic.json,
        info: { previous: statistic.has_previous?, next: statistic.has_next? }
    }
  end
end
