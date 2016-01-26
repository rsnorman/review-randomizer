require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :repos }
  it { is_expected.to have_many :teams }
  it { is_expected.to have_many :team_memberships }
  it { is_expected.to have_many :review_assignments }

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
end
