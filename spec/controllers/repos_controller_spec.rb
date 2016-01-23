require 'rails_helper'

RSpec.describe ReposController, type: :controller do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Repo. As you add validations to Repo, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    Hash[
      company: 'All Things Serve The Code',
      organization: 'Norman Dev',
      name: 'Review Randomizer',
      description: 'Assigns random team members to review Pull Requests',
      url: 'http://www.github.com/review-randomizer',
      owner: @user,
    ]
  end

  let(:invalid_attributes) do
    Hash[
      company: 'All Things Serve The Code',
      organization: 'Norman Dev',
      name: 'Review Randomizer',
      description: 'Assigns random team members to review Pull Requests',
      url: nil
    ]
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all repos as @repos' do
      repo = Repo.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:repos)).to eq([repo])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested repo as @repo' do
      repo = Repo.create! valid_attributes
      get :show, { id: repo.to_param }, valid_session
      expect(assigns(:repo)).to eq(repo)
    end
  end

  describe 'GET #new' do
    it 'assigns a new repo as @repo' do
      get :new, {}, valid_session
      expect(assigns(:repo)).to be_a_new(Repo)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested repo as @repo' do
      repo = Repo.create! valid_attributes
      get :edit, { id: repo.to_param }, valid_session
      expect(assigns(:repo)).to eq(repo)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Repo' do
        expect do
          post :create, { repo: valid_attributes }, valid_session
        end.to change(Repo, :count).by(1)
      end

      it 'assigns a newly created repo as @repo' do
        post :create, { repo: valid_attributes }, valid_session
        expect(assigns(:repo)).to be_a(Repo)
        expect(assigns(:repo)).to be_persisted
      end

      it 'redirects to the created repo' do
        post :create, { repo: valid_attributes }, valid_session
        expect(response).to redirect_to(Repo.last)
      end

      it 'assigns the owner as the current user' do
        post :create, { repo: valid_attributes }, valid_session
        expect(assigns(:repo).owner).to eq @user
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved repo as @repo' do
        post :create, { repo: invalid_attributes }, valid_session
        expect(assigns(:repo)).to be_a_new(Repo)
      end

      it "re-renders the 'new' template" do
        post :create, { repo: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        Hash[
          name: 'PR Review Randomizer'
        ]
      end

      it 'updates the requested repo' do
        repo = Repo.create! valid_attributes
        put :update, { id: repo.to_param, repo: new_attributes }, valid_session
        repo.reload
        expect(repo.name).to eq 'PR Review Randomizer'
      end

      it 'assigns the requested repo as @repo' do
        repo = Repo.create! valid_attributes
        put(
          :update, { id: repo.to_param, repo: valid_attributes }, valid_session
        )
        expect(assigns(:repo)).to eq(repo)
      end

      it 'redirects to the repo' do
        repo = Repo.create! valid_attributes
        put(
          :update, { id: repo.to_param, repo: valid_attributes }, valid_session
        )
        expect(response).to redirect_to(repo)
      end
    end

    context 'with invalid params' do
      it 'assigns the repo as @repo' do
        repo = Repo.create! valid_attributes
        put(
          :update,
          { id: repo.to_param, repo: invalid_attributes },
          valid_session
        )
        expect(assigns(:repo)).to eq(repo)
      end

      it "re-renders the 'edit' template" do
        repo = Repo.create! valid_attributes
        put(
          :update,
          { id: repo.to_param, repo: invalid_attributes },
          valid_session
        )

        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested repo' do
      repo = Repo.create! valid_attributes
      expect do
        delete :destroy, { id: repo.to_param }, valid_session
      end.to change(Repo, :count).by(-1)
    end

    it 'redirects to the repos list' do
      repo = Repo.create! valid_attributes
      delete :destroy, { id: repo.to_param }, valid_session
      expect(response).to redirect_to(repos_url)
    end
  end
end
