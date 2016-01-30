require 'rails_helper'

RSpec.describe TeamMembership, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :team }
  it { is_expected.to have_many :review_assignments }

  it { is_expected.to validate_presence_of :handle }
  it { is_expected.to validate_presence_of :user }
end
