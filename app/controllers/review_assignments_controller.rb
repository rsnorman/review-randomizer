# Controller for assignements to review pull requests
class ReviewAssignmentsController < ApplicationController
  respond_to :html, :json

  load_resource :pull_request
  load_and_authorize_resource :review_assignment, through: :pull_request

  def create
    @review_assignment.save
    respond_with @pull_request, @review_assignment
  end

  def update
    @review_assignment.update(review_assignment_params)
    respond_with @pull_request, @review_assignment
  end

  def destroy
    @review_assignment.destroy
    respond_with @pull_request, @review_assignment
  end

  private

  def review_assignment_params
    params
      .require(:review_assignment)
      .permit(:pull_request_id, :team_membership_id)
  end
end
