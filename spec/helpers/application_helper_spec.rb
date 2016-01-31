require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#full_path' do
    it 'returns full path' do
      expect(helper.full_path('/pull_requests'))
        .to eq 'http://test.host:80/pull_requests'
    end

    context 'without port number' do
      before do
        allow_any_instance_of(ActionController::TestRequest)
          .to receive(:port).and_return nil
      end

      it 'returns full path' do
        expect(helper.full_path('/pull_requests'))
          .to eq 'http://test.host/pull_requests'
      end
    end
  end
end
