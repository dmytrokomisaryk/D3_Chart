require 'passed_tests_statistic'

class ChartsController < ApplicationController
  def index
    @statistic = PassedTestsStatistic.new('session_history').all
    respond_to { |format| format.html }
  end
end
