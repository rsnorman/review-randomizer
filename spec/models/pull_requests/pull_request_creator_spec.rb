require 'rails_helper'

RSpec.describe PullRequests::PullRequestCreator do
  describe '#create' do
    let(:repo) do
      FactoryGirl.create(
        :repo, url: 'https://github.com/rsnorman/review-randomizer'
      )
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:team) { FactoryGirl.create(:team) }

    let(:creator) do
      described_class.new(
        author: user,
        url:    pr_url,
        title:  pr_title
      )
    end
    let(:pr_title) { Faker::Hacker.say_something_smart }
    let(:pr_url) { 'https://github.com/rsnorman/review-randomizer/pull/15' }

    before do
      team.users << user
      team.repos << repo
    end

    it 'sets the pull request title' do
      expect(creator.create.title).to eq pr_title
    end

    it 'sets the pull request number' do
      expect(creator.create.number).to eq 15
    end

    it 'assigns the correct repo' do
      expect(creator.create.repo).to eq repo
    end

    describe 'random review assignments' do
      let(:reviewer1) { FactoryGirl.create(:user) }
      let(:reviewer2) { FactoryGirl.create(:user) }

      before do
        team.users << reviewer1
        team.users << reviewer2
      end

      let(:pull_request) { creator.create }

      it 'assigns two random reviewers' do
        expect(pull_request.users.to_a.sort_by(&:id))
          .to eq([reviewer1, reviewer2])
      end

      context 'with error creating pull request' do
        before do
          allow_any_instance_of(PullRequest)
            .to receive(:persisted?)
            .and_return false
        end

        it 'doesn\'t assign reviewers' do
          expect { creator.create }.to change(ReviewAssignment, :count).by 0
        end
      end
    end
  end
end
