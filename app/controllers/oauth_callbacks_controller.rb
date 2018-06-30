class OauthCallbacksController < ApplicationController

  def create
    result = SignUpOrSignInCommand.run(auth_hash)
    if result.succeeded?
      sign_in(result.user_id)
      redirect_to root_url
    end
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end
end
