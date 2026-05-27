class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @projects = current_user.projects.order(updated_at: :desc) if user_signed_in?
  end
end
