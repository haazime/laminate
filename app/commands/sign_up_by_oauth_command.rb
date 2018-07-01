class SignUpByOauthCommand < ApplicationCommand

  def run(auth_hash)
    user = new_user(auth_hash)
    user.save!
  rescue
    failure
  else
    success(user_id: user.id)
  end

  private

    def new_user(auth_hash)
      Apps::User.new_with_oauth_account(
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
    end
end
