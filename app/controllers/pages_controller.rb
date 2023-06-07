class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @memberships = Membership.where(user: current_user)
    @groups = []
    if @memberships.empty?
      @groups
    else
      @memberships.each do |membership|
        @groups.push(Group.find(membership.group_id))
      end
    end
  end
end
