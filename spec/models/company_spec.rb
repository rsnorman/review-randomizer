require 'rails_helper'

RSpec.describe Company, type: :model do
  it { is_expected.to belong_to :owner }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :domain }
  it { is_expected.to validate_presence_of :owner }

  it { is_expected.to validate_uniqueness_of :domain }
end
