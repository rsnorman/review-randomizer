require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to belong_to :company }
  it { is_expected.to belong_to :leader }
  it { is_expected.to have_and_belong_to_many :repos }
  it { is_expected.to have_many :team_memberships }
  it { is_expected.to have_many :users }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :leader }
  it { is_expected.to validate_presence_of :company }
end
