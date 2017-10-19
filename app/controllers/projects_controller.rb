class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.where(slug: params[:slug]).first
    raise ActiveRecord::RecordNotFound if @project.nil?
  end
end
