require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  login_admin

  let(:valid_attributes) do
    FactoryGirl.attributes_for(:company, owner_id: @admin_user.id)
  end

  let(:invalid_attributes) do
    {
      name: Faker::Company.name,
      domain: nil
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all companies as @companies' do
      company = Company.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested company as @company' do
      company = Company.create! valid_attributes
      get :show, { id: company.to_param }, valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'GET #new' do
    it 'assigns a new company as @company' do
      get :new, {}, valid_session
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested company as @company' do
      company = Company.create! valid_attributes
      get :edit, { id: company.to_param }, valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Company' do
        expect do
          post :create, { company: valid_attributes }, valid_session
        end.to change(Company, :count).by(1)
      end

      it 'assigns a newly created company as @company' do
        post :create, { company: valid_attributes }, valid_session
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it 'redirects to the created company' do
        post :create, { company: valid_attributes }, valid_session
        expect(response).to redirect_to(Company.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved company as @company' do
        post :create, { company: invalid_attributes }, valid_session
        expect(assigns(:company)).to be_a_new(Company)
      end

      it "re-renders the 'new' template" do
        post :create, { company: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'All Things Serve The Code'
        }
      end

      it 'updates the requested company' do
        company = Company.create! valid_attributes
        put(
          :update,
          { id: company.to_param, company: new_attributes },
          valid_session
        )
        company.reload
        expect(company.name).to eq 'All Things Serve The Code'
      end

      it 'assigns the requested company as @company' do
        company = Company.create! valid_attributes
        put(
          :update,
          { id: company.to_param, company: new_attributes },
          valid_session
        )
        expect(assigns(:company)).to eq(company)
      end

      it 'redirects to the company' do
        company = Company.create! valid_attributes
        put(
          :update,
          { id: company.to_param, company: new_attributes },
          valid_session
        )
        expect(response).to redirect_to(company)
      end
    end

    context 'with invalid params' do
      it 'assigns the company as @company' do
        company = Company.create! valid_attributes
        put(
          :update,
          { id: company.to_param, company: invalid_attributes },
          valid_session
        )
        expect(assigns(:company)).to eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        put(
          :update,
          { id: company.to_param, company: invalid_attributes },
          valid_session
        )
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested company' do
      company = Company.create! valid_attributes
      expect do
        delete :destroy, { id: company.to_param }, valid_session
      end.to change(Company, :count).by(-1)
    end

    it 'redirects to the companies list' do
      company = Company.create! valid_attributes
      delete :destroy, { id: company.to_param }, valid_session
      expect(response).to redirect_to(companies_url)
    end
  end
end
