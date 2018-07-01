class ProjectsController < ApplicationController
  before_action :require_user

  private

    def require_user
      unless signed_in?
        redirect_to new_session_url, notice: t('navs.require_user')
      end
    end
end
