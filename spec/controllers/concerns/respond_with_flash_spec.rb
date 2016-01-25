require 'rails_helper'

RSpec.describe RespondWithFlash do
  let(:base_controller) { Class.new { def respond_with(*arg); end } }
  let(:controller) do
    Class.new(base_controller) do
      attr_accessor :flash, :params

      def initialize
        @flash  = {}
        @params = {}
      end

      include RespondWithFlash
    end.new
  end

  describe '#respond_with' do
    context 'with create action' do
      before { controller.params[:action] = 'create' }

      context 'with successfully saved object' do
        it 'sets a success flash notice' do
          controller.respond_with(Repo.new)
          expect(controller.flash[:notice]).to eq 'Repo created successfully.'
        end
      end

      context 'with unsuccessfully saved object' do
        before do
          allow_any_instance_of(Repo)
            .to receive_message_chain('errors.none?')
            .and_return(false)
        end

        it 'sets a failure flash alert' do
          controller.respond_with(Repo.new)
          expect(controller.flash[:alert]).to eq 'Repo was not created.'
        end
      end
    end

    context 'with update action' do
      before { controller.params[:action] = 'update' }

      context 'with successfully updated object' do
        it 'sets a success flash notice' do
          controller.respond_with(Repo.new)
          expect(controller.flash[:notice]).to eq 'Repo updated successfully.'
        end
      end

      context 'with unsuccessfully updated object' do
        before do
          allow_any_instance_of(Repo)
            .to receive_message_chain('errors.none?')
            .and_return(false)
        end

        it 'sets a failure flash alert' do
          controller.respond_with(Repo.new)
          expect(controller.flash[:alert]).to eq 'Repo was not updated.'
        end
      end
    end

    context 'with destroy action' do
      before { controller.params[:action] = 'destroy' }

      context 'with successfully destroyed object' do
        it 'sets a success flash notice' do
          controller.respond_with(Repo.new)
          expect(controller.flash[:notice]).to eq 'Repo destroyed successfully.'
        end
      end

      context 'with unsuccessfully destroyed object' do
        before do
          allow_any_instance_of(Repo)
            .to receive_message_chain('errors.none?')
            .and_return(false)
        end

        it 'sets a failure flash alert' do
          controller.respond_with(Repo.new)
          expect(controller.flash[:alert]).to eq 'Repo was not destroyed.'
        end
      end
    end

    context 'with nested objects' do
      before { controller.params[:action] = 'create' }

      it 'sets a success flash notice' do
        controller.respond_with(Repo.new, PullRequest.new)
        expect(controller.flash[:notice])
          .to eq 'Pull request created successfully.'
      end
    end
  end
end
