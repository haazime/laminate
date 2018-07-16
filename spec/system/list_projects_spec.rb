require 'rails_helper'

describe 'List projects', type: :system do
  it do
    person = sign_up
    sign_in(person)

    visit projects_path

    expect(page).to have_content(I18n.t('projects.index.empty'))
  end
end
