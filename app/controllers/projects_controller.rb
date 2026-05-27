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

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

end

# test
