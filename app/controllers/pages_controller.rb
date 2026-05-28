class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @projects = current_user.projects.order(updated_at: :desc) if user_signed_in?
  end

  # Page "Mon profil"
  def profil
    # l'utilisateur actuellement connecté
    @user = current_user
    # ses projets, pour afficher combien il en a
    @projects = current_user.projects
  end
end
