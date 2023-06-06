class OutcomesController < ApplicationController
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
   end

  def update
  end

  def destroy
  end

  def outcome_params
    params.require(:outcome).permit(:date, :outcome_category, :description, :value, :payment_form)
  end

end
