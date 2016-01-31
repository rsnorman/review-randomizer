require 'rails_helper'

RSpec.describe PullRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/v1/pull_requests')
        .to route_to('api/v1/pull_requests#create')
    end
  end
end
