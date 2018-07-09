require 'rails_helper'

describe LaunchProjectCommand do
  it do
    user = sign_up

    form = ProjectForm.new(name: 'Project ABC')
    r = described_class.run(user, form)

    aggregate_failures do
      project = Project::Project.find(r.project_id)
      expect(project.name).to eq(form.name)

      member = Project::Member.find(r.project_member_id)
      expect(project.members).to include(member)

      #expect(user.project_member_of(project)).to eq(member)
    end
  end
end
