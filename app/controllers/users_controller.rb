class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @group = @user.group
    if @group
      @incomes = Income.where(group: @group).order(:date)
      @outcomes = Outcome.where(group: @group).order(:value)
      @total_income_per_group = @group.incomes.where(user: @group.users.pluck(:id)).sum(:value)
      @total_outcome_per_group = @group.outcomes.where(user: @group.users.pluck(:id)).sum(:value)
      @sorted_data = @user.group.outcomes.group(:outcome_category).sum(:value).sort_by { |category, value| -value }
      if params.dig(:filter, :month).present? && params.dig(:filter, :year).present?
        @total_income_per_group = @group.incomes.where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ?", params[:filter][:month], params[:filter][:year]).sum(:value)
        @total_outcome_per_group = @group.outcomes.where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ?", params[:filter][:month], params[:filter][:year]).sum(:value)
        @sorted_data = @user.group.outcomes.where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ?", params[:filter][:month], params[:filter][:year]).group(:outcome_category).sum(:value).sort_by { |category, value| -value }
      end
      @user_data = sorted_user_data(@group, params.dig(:filter))
      @chart_data = {
        labels: ['Entradas (R$)', 'Saídas (R$)'],
        datasets: [{
          label: '',
          backgroundColor: ['#90eebfa9', '#ff7883a9'],
          borderColor: ['green', 'red'],
          type: 'pie',
          data: [@total_income_per_group, @total_outcome_per_group]
        }]
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

  def sorted_user_data(group, filter = nil)
    user_data = []
    group.users.each do |user|
      if filter.present?
        incomes = user.incomes.where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ? AND group_id = ?", filter[:month], filter[:year], group.id).sum(:value)
        outcomes = user.outcomes.where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ? AND group_id = ?", filter[:month], filter[:year], group.id).sum(:value)
      else
        incomes = user.incomes.where(group: group).sum(:value)
        outcomes = user.outcomes.where(group: group).sum(:value)
      end
      user_data << {
        name: user.name,
        incomes: incomes,
        outcomes: outcomes,
        total: incomes - outcomes
      }
    end
    user_data
  end
end
