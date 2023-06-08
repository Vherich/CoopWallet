class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @memberships = Membership.where(user: current_user)
    @groups = []
    if @memberships.empty?
      @groups
    else
      @memberships.each do |membership|
        @groups.push(Group.find(membership.group_id))
      end
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @incomes = Income.where(group: @group).order(:date)
    @outcomes = Outcome.where(group: @group).order(:date)
    @chart_data = {
      labels: @incomes.pluck(:date),
      datasets: [{
        label: 'Entradas (R$)',
        backgroundColor: '#90eebfa9',
        borderColor: 'black',
        type: 'doughnut',
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
end
