require 'rails_helper'
require 'spec_helper'
require 'passed_tests_statistic'

describe PassedTestsStatistic do
  let(:csv) { PassedTestsStatistic.new('session_history') }

  describe 'read from file' do
    context 'return csv data' do
      it { expect(csv.all).not_to be_empty }
      it { expect(csv.all).to eql(session_history) }
    end
  end
end