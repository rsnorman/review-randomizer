# View helper for user junk
module UsersHelper
  def password_hint
    return unless @minimum_password_length
    "<em>(#{@minimum_password_length} characters minimum)</em>".html_safe
  end
end
