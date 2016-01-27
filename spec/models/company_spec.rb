require 'rails_helper'

RSpec.describe Company, type: :model do
  it { is_expected.to belong_to :owner }

  it { is_expected.to have_many :repos }
  it { is_expected.to have_many :teams }
  it { is_expected.to have_many :users }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :domain }
  it { is_expected.to validate_presence_of :owner }

  it { is_expected.to validate_uniqueness_of :domain }

  describe '#set_token' do
    it 'sets token after create' do
      expect(FactoryGirl.create(:company, token: nil).token).to_not be_nil
    end
  end
end
