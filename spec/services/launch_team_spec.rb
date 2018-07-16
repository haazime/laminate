require 'rails_helper'

xdescribe 'Launch team' do
  it do
    person = sign_up

    form = ProjectForm.new(name: 'Project ABC')
    r = described_class.run(person, form)

    aggregate_failures do
      project = Project::Project.find(r.project_id)
      expect(project.name).to eq(form.name)

      member = Project::Member.find(r.project_member_id)
      expect(project.members).to include(member)

      #expect(person.project_member_of(project)).to eq(member)
    end
  end
end
