class SignUpByOauthCommand < ApplicationCommand

  def run(auth_hash)
    person = new_person(auth_hash)
    person.save!
  rescue
    failure
  else
    success(person_id: person.id)
  end

  private

    def new_person(auth_hash)
      Person::Person.new_with_oauth_account(
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
