require 'rails_helper'

RSpec.describe Repo, type: :model do
  it { is_expected.to belong_to :owner }
  it { is_expected.to belong_to :company }
  it { is_expected.to have_many :pull_requests }
  it { is_expected.to have_and_belong_to_many :teams }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :owner }
  it { is_expected.to validate_presence_of :company }

  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_uniqueness_of :url }
end
