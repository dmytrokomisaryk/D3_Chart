require 'rails_helper'

describe ChartsController, type: :controller do
  describe '#index' do

    context 'renders the index template' do
      subject { get :index }
      it { expect(subject).to render_template(:index) }
    end

    context 'response json for chart' do
      it 'should render json' do
        get :index

        expect(assigns(:statistic)).to include(session_history)
      end
    end
  end

  describe '#slide' do
    context 'response json for chart' do
      let(:json) { JSON.parse(response.body) }

      it 'should render json' do
        post :slide, index: 1

        expect(json['data']).not_to include(session_history)
        expect(json['info']).to eq({ "previous" => true, "next" => true })
      end

      it 'should response information whether the next or previous data' do
        post :slide

        parsed_data = json['info']
        expect(parsed_data['previous']).to be(true)
        expect(parsed_data['next']).to be(false)
      end
    end
  end

  describe '#filter' do
    context 'response json for chart' do
      let(:json) { JSON.parse(response.body) }

      it 'should render json where data has failed test count' do
        post :filter, key: 'failed_tests_count'

        parsed_data = JSON.parse(json['data'])
        passed_tests = parsed_data.select{ |session| session['failed_tests_count'].to_i > 0 }

        expect(passed_tests.count).to eq(parsed_data.count)
      end
    end
  end
end
