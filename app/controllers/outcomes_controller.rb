class OutcomesController < ApplicationController
  before_action :authenticate_user!

  def new
    @outcome = Outcomes.new
  end

  def index
    @group = Group.find(params[:group_id])
    @outcomes = Outcome.where(group: @group).order(:date)
    @chart_data = {
      labels: @outcomes.pluck(:date),
      datasets: [{
        label: 'Saídas (R$)',
        backgroundColor: ['#ff7883a9'],
        borderColor: 'black',
        type: 'bar',
        data: @outcomes.pluck(:value)
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
    @outcome = Outcome.new(outcome_params)
    @outcome.group = @group
    @outcome.user = current_user
    if @outcome.save
      redirect_to group_outcomes_path(@group)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @group = Group.find(params[:group_id])
    @outcome = Outcome.find(params[:id])
    @outcome.update(outcome_params)
    respond_to do |f|
      f.html { redirect_to group_incomes_path(@group)}
      f.text {
        render partial: 'outcomes/outcome', locals: { outcome: @outcome }, formats: :html
      }
    end
  end

  def destroy
    @outcome = Outcome.find(params[:id])
    @outcome.destroy
    redirect_to outcome_path, status: :see_other
  end

  private

  def outcome_params
    params.require(:outcome).permit(:date, :outcome_category, :description, :value, :payment_form)
  end
end
