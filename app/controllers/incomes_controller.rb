class IncomesController < ApplicationController
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
  end

  def update
  end

  def destroy
  end

  def outcome_params
    params.require(:income).permit(:date, :income_category, :description, :value)
  end
end
