require 'rails_helper'

RSpec.describe ReviewAssignmentsController, type: :controller do
  login_user

  let(:team)            { FactoryGirl.create(:team, leader: @user) }
  let(:team_membership) { FactoryGirl.create(:team_membership, team: team) }
  let(:pull_request)    { FactoryGirl.create(:pull_request, author: @user) }
  let(:review_assignment) do
    FactoryGirl.create(
      :review_assignment,
      team_membership: team_membership,
      pull_request: pull_request
    )
  end

  let(:valid_attributes) do
    {
      team_membership_id: team_membership.to_param,
      pull_request_id:    pull_request.to_param
    }
  end

  let(:invalid_attributes) do
    {
      team_membership_id: nil
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    before { review_assignment }
    it 'assigns all review_assignments as @review_assignments' do
      get :index, { pull_request_id: pull_request.to_param }, valid_session
      expect(assigns(:review_assignments)).to eq([review_assignment])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested review_assignment as @review_assignment' do
      get(
        :show,
        {
          id: review_assignment.to_param,
          pull_request_id: pull_request.to_param
        },
        valid_session
      )
      expect(assigns(:review_assignment)).to eq(review_assignment)
    end
  end

  describe 'GET #new' do
    it 'assigns a new review_assignment as @review_assignment' do
      get :new, { pull_request_id: pull_request.to_param }, valid_session
      expect(assigns(:review_assignment)).to be_a_new(ReviewAssignment)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested review_assignment as @review_assignment' do
      get(
        :edit,
        {
          id: review_assignment.to_param,
          pull_request_id: pull_request.to_param
        },
        valid_session
      )
      expect(assigns(:review_assignment)).to eq(review_assignment)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ReviewAssignment' do
        expect do
          post(
            :create,
            {
              review_assignment: valid_attributes,
              pull_request_id: pull_request.to_param
            },
            valid_session
          )
        end.to change(ReviewAssignment, :count).by(1)
      end

      it 'assigns a newly created review_assignment as @review_assignment' do
        post(
          :create,
          {
            review_assignment: valid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(assigns(:review_assignment)).to be_a(ReviewAssignment)
        expect(assigns(:review_assignment)).to be_persisted
      end

      it 'redirects to the created review_assignment' do
        post(
          :create,
          {
            review_assignment: valid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(response).to redirect_to([pull_request, ReviewAssignment.last])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved ' \
         'review_assignment as @review_assignment' do
        post(
          :create,
          {
            review_assignment: invalid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(assigns(:review_assignment)).to be_a_new(ReviewAssignment)
      end

      it "re-renders the 'new' template" do
        post(
          :create,
          {
            review_assignment: invalid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_team_membership) { FactoryGirl.create(:team_membership) }
      let(:new_attributes) do
        {
          team_membership_id: new_team_membership.to_param
        }
      end

      it 'updates the requested review_assignment' do
        put(
          :update,
          {
            id: review_assignment.to_param,
            review_assignment: new_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        review_assignment.reload
        expect(review_assignment.team_membership).to eq new_team_membership
      end

      it 'assigns the requested review_assignment as @review_assignment' do
        put(
          :update,
          {
            id: review_assignment.to_param,
            review_assignment: valid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(assigns(:review_assignment)).to eq(review_assignment)
      end

      it 'redirects to the review_assignment' do
        put(
          :update,
          {
            id: review_assignment.to_param,
            review_assignment: valid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(response).to redirect_to([pull_request, review_assignment])
      end
    end

    context 'with invalid params' do
      it 'assigns the review_assignment as @review_assignment' do
        put(
          :update,
          {
            id: review_assignment.to_param,
            review_assignment: invalid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(assigns(:review_assignment)).to eq(review_assignment)
      end

      it "re-renders the 'edit' template" do
        put(
          :update,
          {
            id: review_assignment.to_param,
            review_assignment: invalid_attributes,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested review_assignment' do
      review_assignment
      expect do
        delete(
          :destroy,
          {
            id: review_assignment.to_param,
            pull_request_id: pull_request.to_param
          },
          valid_session
        )
      end.to change(ReviewAssignment, :count).by(-1)
    end

    it 'redirects to the review_assignments list' do
      delete(
        :destroy,
        {
          id: review_assignment.to_param,
          pull_request_id: pull_request.to_param
        },
        valid_session
      )
      expect(response)
        .to redirect_to(pull_request_review_assignments_url(pull_request))
    end
  end
end
