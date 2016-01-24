require 'rails_helper'

RSpec.describe 'PullRequests', type: :request do
  describe 'GET /pull_requests' do
    it 'works! (now write some real specs)' do
      pending
      get pull_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
