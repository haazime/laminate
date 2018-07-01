class OauthCallbacksController < ApplicationController

  def create
    sign_up_or_find_user(auth_hash) do |user_id, flash|
      sign_in(user_id)
      redirect_to root_url, flash
    end
  end

  private

    def sign_up_or_find_user(auth_hash, &block)
      user = Apps::User.find_by_oauth_account(auth_hash['provider'], auth_hash['uid'])
      return yield(user.id, notice: t('navs.sign_in.succeeded')) if user
      sign_up(auth_hash, &block)
    end

    def sign_up(auth_hash)
      result = SignUpByOauthCommand.run(auth_hash)
      return yield(nil, alert: t('navs.sign_up.failed')) unless result.succeeded?
      yield(result.user_id, notice: t('navs.sign_up.succeeded'))
    end

    def auth_hash
      request.env['omniauth.auth']
    end
end
