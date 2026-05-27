class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @chats = @project.chats.where(user: current_user)
  end
end
