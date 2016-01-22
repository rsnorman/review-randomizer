require 'rails_helper'

RSpec.describe Ability do
  RSpec::Matchers.define :authorize do |action, subject|
    match do |ability|
      has_rule =
        ability.permissions[:can].fetch(action, []).include?(subject.to_s)

      if has_rule && @attributes
        ability.attributes_for(action, subject) == @attributes
      else
        has_rule
      end
    end

    chain :with_attributes do |attributes|
      @attributes = attributes
    end

    failure_message do |ability|
      message  = "expected to be authorized to #{action} #{subject}"
      message += " with #{@attributes}" if @attributes
      message
    end
  end

  describe '#initialize' do
    let(:user) { FactoryGirl.build(:user, role: role, id: 1) }

    context 'with admin user' do
      let(:role) { 'Admin' }

      it 'allows manage all' do
        expect_any_instance_of(Ability).to receive(:can).with(:manage, :all)
        Ability.new(user)
      end
    end

    context 'with non-admin user' do
      let(:role) { 'User' }
      describe 'Repo permissions' do
        it 'allows create' do
          expect(Ability.new(user)).to authorize(:create, Repo)
        end

        it 'allows read for repo owner' do
          expect(Ability.new(user))
            .to authorize(:read, Repo)
            .with_attributes(owner_id: user.id)
        end

        it 'allows update for repo owner' do
          expect(Ability.new(user))
            .to authorize(:update, Repo)
            .with_attributes(owner_id: user.id)
        end

        it 'allows destroy for repo owner' do
          expect(Ability.new(user))
            .to authorize(:destroy, Repo)
            .with_attributes(owner_id: user.id)
        end
      end
    end
  end
end
