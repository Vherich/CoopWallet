class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    unless current_user == nil
      redirect_to user_path(current_user)
    end
  end

  def go_to_user
    unless current_user == nil
      redirect_to user_path(current_user)
    end
  end
end
