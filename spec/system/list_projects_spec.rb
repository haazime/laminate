require 'rails_helper'

describe 'List projects', type: :system do
  it do
    user = sign_up
    sign_in(user)

    visit projects_path

    expect(page).to have_content(I18n.t('projects.index.empty'))
  end
end
