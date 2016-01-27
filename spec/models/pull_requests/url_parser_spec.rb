require 'rails_helper'

RSpec.describe PullRequests::UrlParser do
  describe '#parse' do
    let!(:repo) do
      FactoryGirl.create(
        :repo, url: 'https://github.com/rsnorman/review-randomizer'
      )
    end
    let(:pr_url) do
      'https://github.com/rsnorman/review-randomizer/pull_requests/15'
    end

    let(:parser) { described_class.new(pr_url) }

    it 'sets the pull request number' do
      expect(parser.as_json[:number]).to eq 15
    end

    it 'assigns the correct repo' do
      expect(parser.as_json[:repo]).to eq repo
    end

    context 'without repo matching url' do
      let(:pr_url) do
        'https://github.com/rsnorman/other-repo/pull_requests/1'
      end

      it 'raises missing repo exception' do
        expect { parser.as_json }.to raise_exception(
          described_class::MissingRepo,
          'Could not find repo with URL: https://github.com/rsnorman/other-repo'
        )
      end
    end
  end
end
