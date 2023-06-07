class IncomesController < ApplicationController
  before_action :authenticate_user!

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
    @income.user = current_user
    if @income.save
      redirect_to group_incomes_path(@group)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def income_params
    params.require(:income).permit(:date, :income_category, :description, :value)
  end
end
