class OauthCallbacksController < ApplicationController

  def create
    user_id = sign_up_or_find_user(auth_hash)
    if user_id
      sign_in(user_id)
      redirect_to root_url
    end
  end

  private

    def sign_up_or_find_user(auth_hash)
      user = Apps::User.find_by_oauth_account(auth_hash['provider'], auth_hash['uid'])
      return user.id if user
      sign_up(auth_hash)
    end

    def sign_up(auth_hash)
      result = SignUpByOauthCommand.run(auth_hash)
      return nil unless result.succeeded?
      result.user_id
    end

    def auth_hash
      request.env['omniauth.auth']
    end
end
