class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @group = @user.group
    @incomes = Income.where(group: @group).order(:date)
    @outcomes = Outcome.where(group: @group).order(:value)
    @chart_data = {
      labels: ['Entradas (R$)', 'Saídas (R$)'],
      datasets: [{
        label: '',
        backgroundColor: ['#90eebfa9', '#ff7883a9'],
        borderColor: ['green', 'red'],
        type: 'pie',
        data: [@incomes.sum(:value), @outcomes.sum(:value)]
      }],
    }

    @chart_options = {
      plugins: {
        title: {
          display: true,
          text: 'Entradas e Sáidas (R$)'
        }
      },
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  end
  def profile
    @user = current_user
  end
end
