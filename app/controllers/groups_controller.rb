class GroupsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @group = Group.joins(:memberships).where(memberships: { user_id: current_user.id }).first
  end

  def new
    @group = Group.new
  end

  def create
    #@user = User.find(params[:user_id])
    @group = Group.new(params.require(:group).permit(:group_name))
    @membership = Membership.new
    if @group.save
      @membership.group = @group
      @membership.user = current_user
      @membership.accepted = true
      @membership.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def budgets
  end

  def show
    @group = Group.find(params[:id])
  end
end
