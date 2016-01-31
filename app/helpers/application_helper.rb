# Shared helper methods
module ApplicationHelper
  def full_path(path)
    "#{request.protocol}#{request.host}" \
    "#{request.port ? ":#{request.port}" : ''}#{path}"
  end
end
