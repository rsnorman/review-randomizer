require 'rails_helper'

RSpec.describe Ability do
  RSpec::Matchers.define :authorize do |action, subject|
    match do |ability|
      has_rule =
        ability.permissions[:can].fetch(action, []).include?(subject.to_s)

      if has_rule && @attributes
        ability.send(:rules).detect do |r|
          r.actions.include?(action)     &&
            r.subjects.include?(subject) &&
            r.conditions == @attributes
        end.present?
      else
        has_rule
      end
    end

    chain :with_attributes do |attributes|
      @attributes = attributes
    end

    failure_message do |_ability|
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
            .with_attributes(company_id: user.company_id)
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

      describe 'Team permissions' do
        it 'allows create' do
          expect(Ability.new(user)).to authorize(:create, Team)
        end

        it 'allows read for team leader' do
          expect(Ability.new(user))
            .to authorize(:read, Team)
            .with_attributes(company_id: user.company_id)
        end

        it 'allows update for team leader' do
          expect(Ability.new(user))
            .to authorize(:update, Team)
            .with_attributes(leader_id: user.id)
        end

        it 'allows destroy for team leader' do
          expect(Ability.new(user))
            .to authorize(:destroy, Team)
            .with_attributes(leader_id: user.id)
        end
      end

      describe 'TeamMembership permissions' do
        it 'allows create if team leader' do
          expect(Ability.new(user))
            .to authorize(:manage, TeamMembership)
            .with_attributes(team: { leader_id: user.id })
        end

        it 'allows read for team leader' do
          expect(Ability.new(user))
            .to authorize(:read, TeamMembership)
            .with_attributes(team: { company_id: user.company_id })
        end
      end

      describe 'PullRequest permissions' do
        it 'allows create if repo owner' do
          expect(Ability.new(user))
            .to authorize(:create, PullRequest)
        end

        it 'allows read for repo owner' do
          expect(Ability.new(user))
            .to authorize(:read, PullRequest)
            .with_attributes(repo: { company_id: user.company_id })
        end

        it 'allows update for pull request author' do
          expect(Ability.new(user))
            .to authorize(:manage, PullRequest)
            .with_attributes(author_id: user.id)
        end

        it 'allows update for repo owner' do
          expect(Ability.new(user))
            .to authorize(:manage, PullRequest)
            .with_attributes(repo: { owner_id: user.id })
        end
      end

      describe 'ReviewAssignment permissions' do
        it 'allows create if pull request repo owner' do
          expect(Ability.new(user))
            .to authorize(:manage, ReviewAssignment)
            .with_attributes(pull_request: { repo: { owner_id: user.id } })
        end

        it 'allows create if pull request author' do
          expect(Ability.new(user))
            .to authorize(:manage, ReviewAssignment)
            .with_attributes(pull_request: { author_id: user.id })
        end

        it 'allows create if team leader' do
          expect(Ability.new(user))
            .to authorize(:manage, ReviewAssignment)
            .with_attributes(team: { leader_id: user.id })
        end

        it 'allows read for pull request author' do
          expect(Ability.new(user))
            .to authorize(:read, ReviewAssignment)
        end
      end
    end

    context 'with unregistered user' do
      let(:role) { 'Unregistered' }
      before { allow(user).to receive(:unregistered?).and_return true }

      describe 'PullRequest permissions' do
        it 'allows create' do
          expect(Ability.new(user))
            .to authorize(:create, PullRequest)
        end
      end
    end
  end
end
