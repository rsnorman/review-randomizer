# Overrides respond_with method to set flash messages
module RespondWithFlash
  def respond_with(*args)
    case params[:action]
    when 'create'
      set_flash_message(args.last, params[:action])
    when 'update'
      set_flash_message(args.last, params[:action])
    when 'destroy'
      set_flash_message(args.last, params[:action])
    end

    super
  end

  def set_flash_message(subject, action)
    if subject.errors.none?
      flash[:notice] =
        "#{subject.class.to_s.underscore.humanize} " \
        "#{action.chomp('e')}ed successfully."
    else
      flash[:alert] =
        "#{subject.class.to_s.underscore.humanize} "\
        "was not #{action.chomp('e')}ed."
    end
  end
end
