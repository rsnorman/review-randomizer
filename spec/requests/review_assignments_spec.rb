require 'rails_helper'

RSpec.describe 'ReviewAssignments', type: :request do
  describe 'GET /review_assignments' do
    it 'works! (now write some real specs)' do
      pending
      get review_assignments_path
      expect(response).to have_http_status(200)
    end
  end
end
