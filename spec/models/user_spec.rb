require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to belong_to :company }

  it { is_expected.to have_many :repos }
  it { is_expected.to have_many :teams }
  it { is_expected.to have_many :team_memberships }
  it { is_expected.to have_many :review_assignments }

  it { is_expected.to validate_presence_of :company }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }

  describe '#admin?' do
    let(:user) { FactoryGirl.build(:user, role: role) }

    context 'with user role' do
      let(:role) { 'User' }

      it 'returns false' do
        expect(user.admin?).to be_falsey
      end
    end

    context 'with admin role' do
      let(:role) { 'Admin' }

      it 'returns true' do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe '#unregistered?' do
    let(:user) { FactoryGirl.build(:user) }

    it 'returns false' do
      expect(user.unregistered?).to be_falsey
    end
  end

  describe '#set_company' do
    let(:company) { FactoryGirl.create(:company) }
    let(:user) do
      FactoryGirl.build(
        :user,
        email: "#{Faker::Internet.user_name}@#{company.domain}",
        company: nil
      )
    end

    it 'sets the company based on the email domain' do
      user.save
      expect(user.company).to eq company
    end

    context 'with email domain not matching company' do
      before { user.email = 'other@domain.com' }

      it 'doesn\'t set company' do
        user.save
        expect(user.company).to be_nil
      end
    end
  end
end
