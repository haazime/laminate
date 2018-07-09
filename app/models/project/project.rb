class Project::Project < ApplicationRecord
  has_many :members

  class << self

    def launch(user, name)
      new(name: name) do |project|
        project.members.build
      end
    end
  end
end
