class GroupsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @groups = Group.all
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
      @membership.save
      redirect_to groups_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def budgets
  end

  def show
  end
end