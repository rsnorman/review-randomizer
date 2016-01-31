require 'rails_helper'

RSpec.describe Api::V1::PullRequestsController, type: :controller do
  let(:valid_attributes) do
    {
      title: Faker::Hacker.say_something_smart,
      url:   "#{repo.url}/pulls/1"
    }
  end

  let(:invalid_attributes) do
    {
      title: Faker::Hacker.say_something_smart,
      url:   'http://randombadurl.com'
    }
  end

  let(:valid_session) do
    {

    }
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:repo) { FactoryGirl.create(:repo, owner: user) }
  let(:team) { FactoryGirl.create(:team) }

  before do
    team.repos << repo
    team.users << user
  end

  let(:pull_request) { FactoryGirl.create(:pull_request, repo: repo) }

  describe 'POST #create' do
    before do
      request.env['HTTP_TOKEN']  = user.company.token
      request.env['HTTP_HANDLE'] = user.handle
    end

    context 'with valid params' do
      it 'creates a new PullRequest' do
        expect do
          post(
            :create,
            { pull_request: valid_attributes, format: :json },
            valid_session
          )
        end.to change(PullRequest, :count).by(1)
      end

      it 'assigns a newly created pull_request as @pull_request' do
        post(
          :create,
          { pull_request: valid_attributes, format: :json },
          valid_session
        )
        expect(assigns(:pull_request)).to be_a(PullRequest)
        expect(assigns(:pull_request)).to be_persisted
      end

      it 'assigns the current user as the author of the pull request' do
        post(
          :create,
          { pull_request: valid_attributes, format: :json },
          valid_session
        )
        expect(assigns(:pull_request).author).to eq user
      end
    end

    context 'with pull request already created' do
      let!(:pull_request) do
        PullRequests::PullRequestCreator.new(
          valid_attributes.merge(author: user)
        ).create
      end

      it 'does not create a new pull request' do
        expect do
          post(
            :create,
            { pull_request: valid_attributes, format: :json },
            valid_session
          )
        end.to change(PullRequest, :count).by(0)
      end

      it 'assigns the existing pull_request as @pull_request' do
        post(
          :create,
          { pull_request: valid_attributes, format: :json },
          valid_session
        )
        expect(assigns(:pull_request)).to eq pull_request
      end
    end

    context 'with invalid URL param' do
      it 'returns a 404' do
        post(
          :create,
          {
            pull_request: invalid_attributes,
            repo_id: repo.to_param,
            format: :json
          },
          valid_session
        )
        expect(response.status).to eq 404
      end
    end
  end
end
