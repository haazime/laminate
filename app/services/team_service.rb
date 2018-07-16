class TeamService < ApplicationService

  def run(user, params)
    project = Project::Project.launch(user, params.name)

    transaction do
      project.save!

      user.add_project_member(project.members.first)
    end

    success(project_id: project.id, project_member_id: project.members.first.id)
  end
end
