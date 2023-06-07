class OutcomesController < ApplicationController
  before_action :authenticate_user!

  def new
    @outcome = Outcomes.new
  end

  def index
    @group = Group.find(params[:group_id])
    @outcomes = Outcome.where(group: @group)
  end

  def create
    @group = Group.find(params[:group_id])
    @outcome = Outcome.new(outcome_params)
    @outcome.group = @group
    @outcome.user = current_user
      if @outcome.save
        redirect_to group_outcomes_path(@group)
      else
        render :index, status: :unprocessable_entity
      end
  end

  def update
  end

  def destroy
  end

  private

  def outcome_params
    params.require(:outcome).permit(:date, :outcome_category, :description, :value, :payment_form)
  end
end
