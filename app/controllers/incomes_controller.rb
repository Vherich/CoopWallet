class IncomesController < ApplicationController
  before_action :authenticate_user!

  def new
    @income = Income.new
  end

  def index
    @group = Group.find(params[:group_id])
    @incomes = Income.where(group: @group).order(:date)
    @chart_data = {
      labels: @incomes.pluck(:date),
      datasets: [{
        label: 'Entradas (R$)',
        backgroundColor: '#90eebfa9',
        borderColor: 'black',
        type: 'bar',
        data: @incomes.pluck(:value)
      }]
    }

    @chart_options = {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
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
    @income = Income.find(params[:id])
    @income.update(income_params)
    redirect_to group_incomes_path(@income.group)

  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    redirect_to group_incomes_path(@income.group), status: :see_other
  end

  private

  def income_params
    params.require(:income).permit(:date, :income_category, :description, :value)
  end
end
