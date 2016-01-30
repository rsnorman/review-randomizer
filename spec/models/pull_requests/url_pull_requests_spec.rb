require 'rails_helper'

RSpec.describe PullRequests::UrlPullRequest do
  let(:pull_request)      { FactoryGirl.build(:pull_request) }
  let(:url_pull_request)  { described_class.new(pull_request) }

  describe '#url' do
    before { url_pull_request.url = 'http://github.com/rsnorman/review-random' }

    it 'returns URL' do
      expect(url_pull_request.url)
        .to eq 'http://github.com/rsnorman/review-random'
    end
  end

  describe '#url=' do
    it 'sets the URL' do
      expect do
        url_pull_request.url = 'http://github.com/rsnorman/review-random'
      end.to change(url_pull_request, :url)
        .from(nil)
        .to('http://github.com/rsnorman/review-random')
    end
  end

  it 'delegates to pull request instance' do
    expect(url_pull_request.title).to eq pull_request.title
  end
end
