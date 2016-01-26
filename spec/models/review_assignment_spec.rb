require 'rails_helper'

RSpec.describe ReviewAssignment, type: :model do
  it { is_expected.to belong_to :pull_request }
  it { is_expected.to belong_to :team_membership }

  it { is_expected.to validate_presence_of :pull_request }
  it { is_expected.to validate_presence_of :team_membership }
end
