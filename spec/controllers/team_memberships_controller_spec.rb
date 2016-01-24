require 'rails_helper'

RSpec.describe TeamMembershipsController, type: :controller do
  login_user

  let(:valid_attributes) do
    FactoryGirl.attributes_for(:team_membership)
  end

  let(:invalid_attributes) do
    {
      handle: nil
    }
  end

  let(:valid_session) { {} }

  let(:team) { FactoryGirl.create(:team, leader: @user) }
  let(:team_membership) { FactoryGirl.create(:team_membership, team: team) }

  describe 'GET #index' do
    before { team_membership }

    it 'assigns all team_memberships as @team_memberships' do
      get :index, { team_id: team.to_param }, valid_session
      expect(assigns(:team_memberships)).to eq([team_membership])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested team_membership as @team_membership' do
      get(
        :show,
        { id: team_membership.to_param, team_id: team.to_param },
        valid_session
      )
      expect(assigns(:team_membership)).to eq(team_membership)
    end
  end

  describe 'GET #new' do
    it 'assigns a new team_membership as @team_membership' do
      get :new, { team_id: team.to_param }, valid_session
      expect(assigns(:team_membership)).to be_a_new(TeamMembership)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested team_membership as @team_membership' do
      get(
        :edit,
        { id: team_membership.to_param, team_id: team.to_param },
        valid_session
      )
      expect(assigns(:team_membership)).to eq(team_membership)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new TeamMembership' do
        expect do
          post(
            :create,
            { team_id: team.to_param, team_membership: valid_attributes },
            valid_session
          )
        end.to change(TeamMembership, :count).by(1)
      end

      it 'assigns a newly created team_membership as @team_membership' do
        post(
          :create,
          { team_id: team.to_param, team_membership: valid_attributes },
          valid_session
        )
        expect(assigns(:team_membership)).to be_a(TeamMembership)
        expect(assigns(:team_membership)).to be_persisted
      end

      it 'redirects to the created team_membership' do
        post(
          :create,
          { team_id: team.to_param, team_membership: valid_attributes },
          valid_session
        )
        expect(response).to redirect_to([team, TeamMembership.last])
      end
    end

    context 'with invalid params' do
      it('assigns a newly created but unsaved ' \
         'team_membership as @team_membership') do
        post(
          :create,
          { team_id: team.to_param, team_membership: invalid_attributes },
          valid_session
        )
        expect(assigns(:team_membership)).to be_a_new(TeamMembership)
      end

      it "re-renders the 'new' template" do
        post(
          :create,
          { team_id: team.to_param, team_membership: invalid_attributes },
          valid_session
        )
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          handle: 'xx_superman_xx'
        }
      end

      it 'updates the requested team_membership' do
        put(
          :update,
          {
            id: team_membership.to_param,
            team_membership: new_attributes,
            team_id: team.to_param
          },
          valid_session
        )
        team_membership.reload
        expect(team_membership.handle).to eq 'xx_superman_xx'
      end

      it 'assigns the requested team_membership as @team_membership' do
        put(
          :update,
          {
            id: team_membership.to_param,
            team_membership: new_attributes,
            team_id: team.to_param
          },
          valid_session
        )
        expect(assigns(:team_membership)).to eq(team_membership)
      end

      it 'redirects to the team_membership' do
        put(
          :update,
          {
            id: team_membership.to_param,
            team_membership: new_attributes,
            team_id: team.to_param
          },
          valid_session
        )
        expect(response).to redirect_to([team, team_membership])
      end
    end

    context 'with invalid params' do
      it 'assigns the team_membership as @team_membership' do
        put(
          :update,
          {
            id: team_membership.to_param,
            team_membership: invalid_attributes,
            team_id: team.to_param
          },
          valid_session
        )
        expect(assigns(:team_membership)).to eq(team_membership)
      end

      it "re-renders the 'edit' template" do
        put(
          :update,
          {
            id: team_membership.to_param,
            team_membership: invalid_attributes,
            team_id: team.to_param
          },
          valid_session
        )
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { team_membership }

    it 'destroys the requested team_membership' do
      expect do
        delete(
          :destroy,
          { id: team_membership.to_param, team_id: team.to_param },
          valid_session
        )
      end.to change(TeamMembership, :count).by(-1)
    end

    it 'redirects to the team_memberships list' do
      delete(
        :destroy,
        { id: team_membership.to_param, team_id: team.to_param },
        valid_session
      )
      expect(response).to redirect_to(team_team_memberships_url(team))
    end
  end
end
