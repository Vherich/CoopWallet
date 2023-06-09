class MembershipsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @membership = Membership.new
  end

  def create
    @group = Group.find(params[:group_id])
    @membership = Membership.new
    @user = User.find_by(email: membership_params[:user])
    if @user.group.nil?
      @membership.group = @group
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
    redirect_to groups_path
  end

  private

  def membership_params
    params.require(:membership).permit(:user)
  end
end
