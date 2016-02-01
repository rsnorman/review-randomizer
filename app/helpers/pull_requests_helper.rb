# View helper for pull requests
module PullRequestsHelper
  def author_name(author)
    author.respond_to?(:name) ? author.name : "@#{author.handle}"
  end
end
