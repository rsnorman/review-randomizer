require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  login_user

  let(:repo) { FactoryGirl.create(:repo) }
  let(:valid_attributes) do
    FactoryGirl.attributes_for(:team, leader: @user).tap do |attrs|
      attrs[:repo_ids] = [repo.id]
    end
  end

  let(:invalid_attributes) do
    FactoryGirl.attributes_for(:team).tap do |attrs|
      attrs[:name] = nil
    end
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all teams as @teams' do
      team = FactoryGirl.create(:team, leader: @user)
      get :index, {}, valid_session
      expect(assigns(:teams)).to eq([team])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested team as @team' do
      team = FactoryGirl.create(:team, leader: @user)
      get :show, { id: team.to_param }, valid_session
      expect(assigns(:team)).to eq(team)
    end
  end

  describe 'GET #new' do
    it 'assigns a new team as @team' do
      get :new, {}, valid_session
      expect(assigns(:team)).to be_a_new(Team)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested team as @team' do
      team = FactoryGirl.create(:team, leader: @user)
      get :edit, { id: team.to_param }, valid_session
      expect(assigns(:team)).to eq(team)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Team' do
        expect do
          post :create, { team: valid_attributes }, valid_session
        end.to change(Team, :count).by(1)
      end

      it 'assigns a newly created team as @team' do
        post :create, { team: valid_attributes }, valid_session
        expect(assigns(:team)).to be_a(Team)
        expect(assigns(:team)).to be_persisted
      end

      it 'assigns a repo to the team' do
        post :create, { team: valid_attributes }, valid_session
        expect(assigns(:team).repos).to include(repo)
      end

      it 'redirects to the created team' do
        post :create, { team: valid_attributes }, valid_session
        expect(response).to redirect_to(Team.last)
      end

      it 'assigns the leader as the current user' do
        post :create, { team: valid_attributes }, valid_session
        expect(assigns(:team).leader).to eq @user
      end

      it 'assigns the company as the current user\'s company' do
        post :create, { team: valid_attributes }, valid_session
        expect(assigns(:team).company).to eq @user.company
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved team as @team' do
        post :create, { team: invalid_attributes }, valid_session
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the 'new' template" do
        post :create, { team: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_repo) { FactoryGirl.create(:repo) }
      let(:new_attributes) do
        Hash[
          name: 'Centralmotrons',
          repo_ids: [repo, new_repo]
        ]
      end

      it 'updates the requested team' do
        team = FactoryGirl.create(:team, leader: @user)
        put :update, { id: team.to_param, team: new_attributes }, valid_session
        team.reload
        expect(team.name).to eq('Centralmotrons')
      end

      it 'assigns the new repo' do
        team = FactoryGirl.create(:team, leader: @user)
        put :update, { id: team.to_param, team: new_attributes }, valid_session
        team.reload
        expect(team.repos).to include(repo)
      end

      it 'assigns the requested team as @team' do
        team = FactoryGirl.create(:team, leader: @user)
        put(
          :update, { id: team.to_param, team: valid_attributes }, valid_session
        )
        expect(assigns(:team)).to eq(team)
      end

      it 'redirects to the team' do
        team = FactoryGirl.create(:team, leader: @user)
        put(
          :update, { id: team.to_param, team: valid_attributes }, valid_session
        )
        expect(response).to redirect_to(team)
      end
    end

    context 'with invalid params' do
      it 'assigns the team as @team' do
        team = FactoryGirl.create(:team, leader: @user)
        put(
          :update,
          { id: team.to_param, team: invalid_attributes },
          valid_session
        )
        expect(assigns(:team)).to eq(team)
      end

      it "re-renders the 'edit' template" do
        team = FactoryGirl.create(:team, leader: @user)
        put(
          :update,
          { id: team.to_param, team: invalid_attributes },
          valid_session
        )
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested team' do
      team = FactoryGirl.create(:team, leader: @user)
      expect do
        delete :destroy, { id: team.to_param }, valid_session
      end.to change(Team, :count).by(-1)
    end

    it 'redirects to the teams list' do
      team = FactoryGirl.create(:team, leader: @user)
      delete :destroy, { id: team.to_param }, valid_session
      expect(response).to redirect_to(teams_url)
    end
  end
end
