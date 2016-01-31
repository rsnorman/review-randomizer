require 'rails_helper'

RSpec.describe SecureFind do
  let(:controller) do
    Class.new do
      include SecureFind
    end.new
  end

  describe '#find_resource_by' do
    let!(:company) { FactoryGirl.create(:company) }

    it 'returns the matching resource' do
      expect(controller.find_resource_by(Company, :token, company.token))
        .to eq company
    end

    it 'uses Devise.secure_compare to find resource' do
      expect(Devise)
        .to receive(:secure_compare)
        .with(company.token, company.token)
      controller.find_resource_by(Company, :token, company.token)
    end

    context 'with multiple resources' do
      let!(:company2) { FactoryGirl.create(:company) }

      it 'does not exit upon first find' do
        expect(Devise).to receive(:secure_compare).twice
        controller.find_resource_by(Company, :token, company.token)
      end
    end

    context 'with nil value' do
      it 'returns nil' do
        expect(controller.find_resource_by(Company, :token, nil))
          .to be_nil
      end
    end
  end
end
