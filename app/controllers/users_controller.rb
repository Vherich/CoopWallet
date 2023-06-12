class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @group = @user.group
    if @group
      @incomes = Income.where(group: @group).order(:date)
      @outcomes = Outcome.where(group: @group).order(:value)
      @total_income_per_group = @user.group.memberships.map { |membership| membership.user.incomes.sum(:value) }.sum
      @total_outcome_per_group = @user.group.memberships.map { |membership| membership.user.outcomes.sum(:value) }.sum
      @chart_data = {
        labels: ['Entradas (R$)', 'Saídas (R$)'],
        datasets: [{
          label: '',
          backgroundColor: ['#90eebfa9', '#ff7883a9'],
          borderColor: ['green', 'red'],
          type: 'pie',
          data: [@total_income_per_group, @total_outcome_per_group]
        }],
      }

      @chart_options = {
        plugins: {
          legend: {
            display: false
          },
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
  end
  def profile
    @user = current_user
  end
end
