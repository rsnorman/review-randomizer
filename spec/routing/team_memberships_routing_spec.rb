require "rails_helper"

RSpec.describe TeamMembershipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/teams/1/team_memberships").to route_to("team_memberships#index", team_id: "1")
    end

    it "routes to #new" do
      expect(:get => "/teams/1/team_memberships/new").to route_to("team_memberships#new", team_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/teams/1/team_memberships/1").to route_to("team_memberships#show", :id => "1", team_id: "1")
    end

    it "routes to #edit" do
      expect(:get => "/teams/1/team_memberships/1/edit").to route_to("team_memberships#edit", :id => "1", team_id: "1")
    end

    it "routes to #create" do
      expect(:post => "/teams/1/team_memberships").to route_to("team_memberships#create", team_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/teams/1/team_memberships/1").to route_to("team_memberships#update", :id => "1", team_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/teams/1/team_memberships/1").to route_to("team_memberships#update", :id => "1", team_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/teams/1/team_memberships/1").to route_to("team_memberships#destroy", :id => "1", team_id: "1")
    end

  end
end
