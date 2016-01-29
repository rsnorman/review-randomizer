require 'rails_helper'

RSpec.describe RepoPullRequestsController, type: :controller do
  login_user

  let(:valid_attributes) do
    FactoryGirl.attributes_for(:pull_request)
  end

  let(:invalid_attributes) do
    {
      title: nil
    }
  end

  let(:valid_session) { {} }

  let(:repo) { FactoryGirl.create(:repo, owner: @user) }
  let(:pull_request) { FactoryGirl.create(:pull_request, repo: repo) }

  describe 'GET #index' do
    before { pull_request }

    it 'assigns all pull_requests as @pull_requests' do
      get :index, { repo_id: repo.to_param }, valid_session
      expect(assigns(:pull_requests)).to eq([pull_request])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested pull_request as @pull_request' do
      get(
        :show,
        { id: pull_request.to_param, repo_id: repo.to_param },
        valid_session
      )
      expect(assigns(:pull_request)).to eq(pull_request)
    end
  end

  describe 'GET #new' do
    it 'assigns a new pull_request as @pull_request' do
      get :new, { repo_id: repo.to_param }, valid_session
      expect(assigns(:pull_request)).to be_a_new(PullRequest)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested pull_request as @pull_request' do
      get(
        :edit,
        { id: pull_request.to_param, repo_id: repo.to_param },
        valid_session
      )
      expect(assigns(:pull_request)).to eq(pull_request)
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

    context 'with invalid params' do
      it 'assigns a newly created but unsaved pull_request as @pull_request' do
        post(
          :create,
          { pull_request: invalid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(assigns(:pull_request)).to be_a_new(PullRequest)
      end

      it "re-renders the 'new' template" do
        post(
          :create,
          { pull_request: invalid_attributes, repo_id: repo.to_param },
          valid_session
        )
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { title: 'Fixing all my broken specs' }
      end

      it 'updates the requested pull_request' do
        put(
          :update,
          {
            id: pull_request.to_param,
            pull_request: new_attributes,
            repo_id: repo.to_param
          },
          valid_session
        )
        pull_request.reload
        expect(pull_request.title).to eq 'Fixing all my broken specs'
      end

      it 'assigns the requested pull_request as @pull_request' do
        put(
          :update,
          {
            id: pull_request.to_param,
            pull_request: valid_attributes,
            repo_id: repo.to_param
          },
          valid_session
        )
        expect(assigns(:pull_request)).to eq(pull_request)
      end

      it 'redirects to the pull_request' do
        put(
          :update,
          {
            id: pull_request.to_param,
            pull_request: valid_attributes,
            repo_id: repo.to_param
          },
          valid_session
        )
        expect(response).to redirect_to([repo, pull_request])
      end
    end

    context 'with invalid params' do
      it 'assigns the pull_request as @pull_request' do
        put(
          :update,
          {
            id: pull_request.to_param,
            pull_request: invalid_attributes,
            repo_id: repo.to_param
          },
          valid_session
        )
        expect(assigns(:pull_request)).to eq(pull_request)
      end

      it "re-renders the 'edit' template" do
        put(
          :update,
          {
            id: pull_request.to_param,
            pull_request: invalid_attributes,
            repo_id: repo.to_param
          },
          valid_session
        )
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { pull_request }
    it 'destroys the requested pull_request' do
      expect do
        delete(
          :destroy,
          { id: pull_request.to_param, repo_id: repo.to_param },
          valid_session
        )
      end.to change(PullRequest, :count).by(-1)
    end

    it 'redirects to the pull_requests list' do
      delete(
        :destroy,
        { id: pull_request.to_param, repo_id: repo.to_param },
        valid_session
      )
      expect(response).to redirect_to(repo_pull_requests_url(repo))
    end
  end
end
