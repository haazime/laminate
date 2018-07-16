class ProjectsController < ApplicationController
  before_action :ensure_signed_in

  def new
    @form = NewProjectForm.new
  end
end
