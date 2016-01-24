# View helper methods for team memberships
module TeamMembershipsHelper
  def member_name(membership)
    membership.user.try(:name) || "@#{membership.handle}"
  end
end
