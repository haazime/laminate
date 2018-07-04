class ProjectsController < ApplicationController
  before_action :require_user

  def new
    @form = NewProjectForm.new
  end
end
