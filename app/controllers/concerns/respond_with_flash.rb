# Overrides respond_with method to set flash messages
module RespondWithFlash
  FLASH_ACTIONS = %w(create update destroy).map(&:freeze).freeze

  def respond_with(*args)
    set_flash_message(args.last, params[:action]) if set_flash_message?
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

  def set_flash_message?
    FLASH_ACTIONS.include?(params[:action])
  end
end
