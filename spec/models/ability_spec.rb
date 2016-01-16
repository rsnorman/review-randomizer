require 'rails_helper'

RSpec.describe Ability do
  describe '#initialize' do
    let(:user) { FactoryGirl.build(:user, role: role) }

    context 'with admin user' do
      let(:role) { 'Admin' }

      it 'allows manage all' do
        expect_any_instance_of(Ability).to receive(:can).with(:manage, :all)
        Ability.new(user)
      end
    end

    context 'with non-admin user' do
      let(:role) { 'User' }

      it 'allows read all' do
        expect_any_instance_of(Ability).to receive(:can).with(:read, :all)
        Ability.new(user)
      end
    end
  end
end
