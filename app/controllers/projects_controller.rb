class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @chats = @project.chats
    # @chats = @project.chats.where(user: current_user)
  end

  def index
    @projects = current_user.projects
  end

  # GET /projects/new → affiche le formulaire
  def new
    @project = Project.new
  end

  # POST /projects → traite le formulaire
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to @project, notice: "Projet créé avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id → supprime un projet
  def destroy
    # on cherche le projet parmi ceux de l'utilisateur connecté (sécurité)
    @project = current_user.projects.find(params[:id])
    # on supprime le projet de la base de données
    @project.destroy
    # on revient à l'accueil en gardant le mode suppression actif (paramètre suppression=1)
    redirect_to root_path(suppression: 1), notice: "Projet supprimé."
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

end

# test
