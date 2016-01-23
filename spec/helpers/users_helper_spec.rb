require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#password_hint' do
    before { assign(:minimum_password_length, 10) }

    it 'returns minimum number of characters' do
      expect(helper.password_hint).to eq '<em>(10 characters minimum)</em>'
    end

    context 'without password minimum' do
      before { assign(:minimum_password_length, nil) }

      it 'returns nil' do
        expect(helper.password_hint).to be_nil
      end
    end
  end
end
