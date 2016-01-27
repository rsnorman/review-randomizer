# Controller for managing companies
class CompaniesController < ApplicationController
  respond_to :html

  load_and_authorize_resource

  def create
    @company.save
    respond_with @company
  end

  def update
    @company.update(company_params)
    respond_with @company
  end

  def destroy
    @company.destroy
    respond_with @company
  end

  private

  def company_params
    params.require(:company).permit(:name, :domain).tap do |params|
      params[:owner] = current_user
    end
  end
end
