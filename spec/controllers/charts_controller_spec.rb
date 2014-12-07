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
        expect(assigns(:statistic)).to eql(session_history)
      end
    end
  end
end
