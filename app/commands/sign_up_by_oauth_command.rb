class SignUpByOauthCommand < ApplicationCommand

  def run(auth_hash)
    user =
      Apps::User.new(
        name: auth_hash['info']['name'],
        email: auth_hash['info']['email'],
        avatar_url: auth_hash['info']['image']
      ) do |u|
        u.build_oauth_account(provider: auth_hash['provider'], uid: auth_hash['uid'])
      end
    user.save!
    success
  end
end
