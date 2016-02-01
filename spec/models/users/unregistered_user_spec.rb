require 'rails_helper'

RSpec.describe Users::UnregisteredUser do
  let(:team_membership) { FactoryGirl.build(:team_membership) }
  let(:user) { described_class.new(team_membership) }

  describe '.primary_key' do
    it 'returns "id"' do
      expect(described_class.primary_key).to eq 'id'
    end
  end

  describe '.to_s' do
    it 'returns "TeamMembership"' do
      expect(described_class.to_s).to eq 'TeamMembership'
    end
  end

  describe '.base_class' do
    it 'returns TeamMembership class' do
      expect(described_class.base_class).to eq TeamMembership
    end
  end

  describe '#admin?' do
    it 'returns false' do
      expect(user.admin?).to be_falsey
    end
  end

  describe '#unregistered?' do
    it 'returns true' do
      expect(user.unregistered?).to be_truthy
    end
  end

  describe '#role' do
    it 'returns "Unregistered"' do
      expect(user.role).to eq 'Unregistered'
    end
  end

  describe '==' do
    context 'with id equal' do
      it 'returns true' do
        expect(user == TeamMembership.new(id: team_membership.id)).to eq true
      end
    end

    context 'with id not equal' do
      it 'returns false' do
        expect(user == TeamMembership.new(id: -1)).to eq false
      end
    end
  end
end
