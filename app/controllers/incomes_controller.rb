class IncomesController < ApplicationController
  def new
    @income = Incomes.new
  end

  def index
    @group = Group.find(params[:group_id])
    @incomes = Income.where(group: @group)
  end

  def create
    @group = Group.find(params[:group_id])
    @income = Income.new(income_params)
    @income.group = @group
  end

  def update
  end

  def destroy
  end

  def outcome_params
    params.require(:income).permit(:date, :income_category, :description, :value)
  end







end
