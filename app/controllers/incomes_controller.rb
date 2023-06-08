class IncomesController < ApplicationController
  def new
    @income = Income.new
  end

  def index
    @group = Group.find(params[:group_id])
    @incomes = Income.where(group: @group)
    @chart_data = {
      labels: Income.where(group_id: @group.id).date,
      datasets: [{
        label: 'My First dataset',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: [37, 83, 78, 54, 12, 5, 91818]
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
