class MembershipsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @membership = Membership.new
  end

  def destroy
  end
end
