require 'rails_helper'
require 'csv_parser'

describe CsvParser do
  let(:csv) { CsvParser.new('session_history') }

  describe 'read from file' do
    context 'return csv data' do
      it { expect(csv.json).not_to be_empty }
      it { expect(csv.json).to include(session_history) }
    end
  end
end