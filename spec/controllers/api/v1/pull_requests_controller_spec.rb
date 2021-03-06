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

  let(:valid_session) { Hash[] }

  let(:user)    { FactoryGirl.create(:user) }
  let(:repo)    { FactoryGirl.create(:repo) }
  let(:team)    { FactoryGirl.create(:team) }

  before do
    team.repos << repo
    team.users << user
  end

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

    context 'with unregistered valid handle' do
      let(:team_membership) do
        FactoryGirl.create(:team_membership, handle: 'CosmoKramer', team: team)
      end

      before do
        request.env['HTTP_HANDLE'] = team_membership.handle
      end

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

      it 'assigns the a temporary user as the author of the pull request' do
        post(
          :create,
          { pull_request: valid_attributes, format: :json },
          valid_session
        )
        expect(assigns(:pull_request).author)
          .to eq Users::UnregisteredUser.new(team_membership)
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

    context 'with user not on a repo team' do
      before do
        user.teams.delete(team)
      end

      it 'returns a 404' do
        post(
          :create,
          {
            pull_request: valid_attributes,
            repo_id: repo.to_param,
            format: :json
          },
          valid_session
        )
        expect(response.status).to eq 404
      end
    end

    context 'with invalid token' do
      before { request.env['HTTP_TOKEN'] = 'BADJUNK' }

      it 'returns unauthorized' do
        post(
          :create,
          pull_request: valid_attributes,
          repo_id: repo.to_param,
          format: :json
        )
        expect(response.status).to eq 401
      end
    end

    context 'with invalid user handle' do
      before { request.env['HTTP_HANDLE'] = 'BadJunk' }

      it 'returns unauthorized' do
        post(
          :create,
          pull_request: valid_attributes,
          repo_id: repo.to_param,
          format: :json
        )
        expect(response.status).to eq 401
      end
    end
  end
end
