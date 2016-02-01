module Users
  # Decorator for team membership to behave like user
  class UnregisteredUser < Delegator
    def self.primary_key
      'id'
    end

    def self.to_s
      TeamMembership.to_s
    end

    def self.base_class
      TeamMembership
    end

    def ==(other)
      id == other.id
    end

    def __getobj__
      @delegate_sd_obj
    end

    def __setobj__(obj)
      @delegate_sd_obj = obj
    end
  end
end
