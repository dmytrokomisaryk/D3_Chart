require 'rails_helper'
require 'spec_helper'
require 'csv_parser'

describe CsvParser do
  let(:csv) { CsvParser.new('session_history') }

  describe 'read from file' do
    context 'return csv data' do
      it { expect(csv.json).not_to be_empty }
      it { expect(csv.json).to include(session_history) }
    end

    context 'return csv limited data' do
      it { expect(JSON.parse(csv.max_count(5).paginate(0).json)).not_to be_empty }
      it { expect(JSON.parse(csv.max_count(5).paginate(0).json).count).to eq(5) }
    end
  end
end