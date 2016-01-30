require 'rails_helper'

RSpec.describe PullRequestsController, type: :controller do
  login_user

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

  let(:valid_session) { {} }

  let(:repo) { FactoryGirl.create(:repo, owner: @user) }
  let(:team) { FactoryGirl.create(:team) }

  before do
    team.repos << repo
    team.users << @user
  end

  let(:pull_request) { FactoryGirl.create(:pull_request, repo: repo) }

  describe 'GET #new' do
    it 'assigns a new pull_request as @pull_request' do
      get :new, { repo_id: repo.to_param }, valid_session
      expect(assigns(:pull_request)).to be_a_new(PullRequests::UrlPullRequest)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new PullRequest' do
        expect do
          post(
            :create,
            { pull_request: valid_attributes, repo_id: repo.to_param },
            valid_session
          )
        end.to change(PullRequest, :count).by(1)
      end

      it 'assigns a newly created pull_request as @pull_request' do
        post(
          :create,
          { pull_request: valid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(assigns(:pull_request)).to be_a(PullRequest)
        expect(assigns(:pull_request)).to be_persisted
      end

      it 'assigns the current user as the author of the pull request' do
        post(
          :create,
          { pull_request: valid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(assigns(:pull_request).author).to eq @user
      end

      it 'redirects to the created pull_request' do
        post(
          :create,
          { pull_request: valid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(response).to redirect_to([repo, PullRequest.last])
      end
    end

    context 'with invalid URL param' do
      it 'assigns a newly created but unsaved pull_request as @pull_request' do
        post(
          :create,
          { pull_request: invalid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(assigns(:pull_request)).to be_a_new(PullRequests::UrlPullRequest)
      end

      it "re-renders the 'new' template" do
        post(
          :create,
          { pull_request: invalid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(response).to render_template('new')
      end

      it 'alerts that the repo does not exist' do
        post(
          :create,
          { pull_request: invalid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(session['flash']['flashes']['alert'])
          .to eq 'Could not find repo with URL: http://randombadurl.com'
      end
    end

    context 'with creator not assigned to repo' do
      before { team.users.delete(@user) }

      it 'assigns a newly created but unsaved pull_request as @pull_request' do
        post(
          :create,
          { pull_request: valid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(assigns(:pull_request)).to be_a_new(PullRequests::UrlPullRequest)
      end

      it "re-renders the 'new' template" do
        post(
          :create,
          { pull_request: valid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(response).to render_template('new')
      end

      it 'alerts that pull request author is not in correct team' do
        post(
          :create,
          { pull_request: valid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(session['flash']['flashes']['alert'])
          .to eq 'User not on team tied to pull request\'s repo'
      end
    end
  end
end
