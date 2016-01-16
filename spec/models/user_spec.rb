require 'rails_helper'

RSpec.describe User, type: :model do
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
