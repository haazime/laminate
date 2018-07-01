class SignUpByOauthCommand < ApplicationCommand

  def run(auth_hash)
    user = Apps::User.create_with_oauth_account!(
      {
        name: auth_hash['info']['name'],
        email: auth_hash['info']['email'],
        avatar_url: auth_hash['info']['image'],
      },
      {
        provider: auth_hash['provider'],
        uid: auth_hash['uid']
      }
    )
  rescue
    failure
  else
    success(user_id: user.id)
  end
end
