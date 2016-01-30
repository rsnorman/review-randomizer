require 'rails_helper'

RSpec.describe PullRequest, type: :model do
  it { is_expected.to belong_to :repo }
  it { is_expected.to belong_to :author }
  it { is_expected.to have_many :users }

  it { is_expected.to validate_presence_of :repo }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :author }
  it { is_expected.to validate_presence_of :number }

  it { is_expected.to validate_uniqueness_of :number }
end
