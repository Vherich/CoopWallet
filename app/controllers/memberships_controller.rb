class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    @membership = Membership.new
  end

  def create
    @group = Group.find(params[:group_id])
    @membership = Membership.new
    @user = User.find_by(email: membership_params[:user])
    if @user.group.nil?
      @membership.group_reference = @group.id
      @membership.user = @user
      if @membership.save
        redirect_to root_path
      else
        flash[:alert] = "Usuário não encontrado"
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Usuário já possui um grupo"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @membership = Membership.find_by(user: current_user)
    @membership.destroy
    redirect_to users_path
  end

  def invites
    @memberships = Membership.where(accepted: false, user: current_user)
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.update_attribute("accepted", true)
    @membership.group = Group.find(@membership.group_reference)
    @membership.save
    redirect_to user_path(@membership.user)
  end

  def deny
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to invites_memberships_path
  end

  private

  def membership_params
    params.require(:membership).permit(:user)
  end
end
