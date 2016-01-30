module PullRequests
  # Decorator for a PullRequest built from a URL
  class UrlPullRequest < Delegator
    attr_accessor :url

    def __getobj__
      @delegate_sd_obj
    end

    def __setobj__(obj)
      @delegate_sd_obj = obj
    end
  end
end
