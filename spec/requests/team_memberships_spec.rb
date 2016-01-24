require 'rails_helper'

RSpec.describe 'TeamMemberships', type: :request do
  describe 'GET /team_memberships' do
    it 'works! (now write some real specs)' do
      pending
      get team_memberships_path
      expect(response).to have_http_status(200)
    end
  end
end
