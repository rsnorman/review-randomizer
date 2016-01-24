# Application controller junk
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :handle
  end

  def respond_with(*args)
    case params[:action]
    when 'create'
      set_flash_message(args.first, params[:action])
    when 'update'
      set_flash_message(args.first, params[:action])
    when 'destroy'
      set_flash_message(args.first, params[:action])
    end

    super
  end

  def set_flash_message(subject, action)
    if subject.errors.none?
      flash[:notice] =
        "#{subject.class.to_s.humanize} #{action.chomp('e')}ed successfully."
    else
      flash[:alert] =
        "#{subject.class.to_s.humanize} was not #{action.chomp('e')}ed."
    end
  end
end
