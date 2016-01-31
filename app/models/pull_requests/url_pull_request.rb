module PullRequests
  # Decorator for a PullRequest built from a URL
  class UrlPullRequest < Delegator
    attr_accessor :url

    def self.find_by_url(url)
      PullRequest.find_by(PullRequests::UrlParser.new(url).as_json)
    end

    def __getobj__
      @delegate_sd_obj
    end

    def __setobj__(obj)
      @delegate_sd_obj = obj
    end
  end
end
