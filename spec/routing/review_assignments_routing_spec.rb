require "rails_helper"

RSpec.describe ReviewAssignmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/pull_requests/1/review_assignments")
        .to route_to("review_assignments#index", pull_request_id: '1')
    end

    it "routes to #new" do
      expect(:get => "/pull_requests/1/review_assignments/new")
        .to route_to("review_assignments#new", pull_request_id: '1')
    end

    it "routes to #show" do
      expect(:get => "/pull_requests/1/review_assignments/1")
        .to route_to("review_assignments#show", :id => "1", pull_request_id: '1')
    end

    it "routes to #edit" do
      expect(:get => "/pull_requests/1/review_assignments/1/edit")
        .to route_to("review_assignments#edit", :id => "1", pull_request_id: '1')
    end

    it "routes to #create" do
      expect(:post => "/pull_requests/1/review_assignments")
        .to route_to("review_assignments#create", pull_request_id: '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "/pull_requests/1/review_assignments/1").to route_to(
        "review_assignments#update", :id => "1", pull_request_id: '1'
      )
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pull_requests/1/review_assignments/1").to route_to(
        "review_assignments#update", :id => "1", pull_request_id: '1'
      )
    end

    it "routes to #destroy" do
      expect(:delete => "/pull_requests/1/review_assignments/1").to route_to(
        "review_assignments#destroy", :id => "1", pull_request_id: '1'
      )
    end
  end
end
