class SessionsController < ApplicationController

  def destroy
    sign_out
    redirect_to new_session_url, notice: t('navs.signed_out')
  end
end
