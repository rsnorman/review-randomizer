require 'rails_helper'

RSpec.describe PullRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/repos/1/pull_requests')
        .to route_to('pull_requests#index', repo_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/repos/1/pull_requests/new')
        .to route_to('pull_requests#new', repo_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/repos/1/pull_requests/1')
        .to route_to('pull_requests#show', id: '1', repo_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/repos/1/pull_requests/1/edit')
        .to route_to('pull_requests#edit', id: '1', repo_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/repos/1/pull_requests')
        .to route_to('pull_requests#create', repo_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/repos/1/pull_requests/1')
        .to route_to('pull_requests#update', id: '1', repo_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/repos/1/pull_requests/1')
        .to route_to('pull_requests#update', id: '1', repo_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/repos/1/pull_requests/1')
        .to route_to('pull_requests#destroy', id: '1', repo_id: '1')
    end
  end
end
