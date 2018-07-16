class OauthCallbacksController < ApplicationController
  before_action :ensure_signed_out

  def create
    person_id = sign_up_or_find_person(auth_hash)
    if person_id
      sign_in(person_id)
      redirect_to root_url, notice: t('navs.signed_in')
    end
  end

  private

    def sign_up_or_find_person(auth_hash, &block)
      person = Person::Person.find_by_oauth_account(auth_hash['provider'], auth_hash['uid'])
      return person.id if person
      sign_up(auth_hash)
    end

    def sign_up(auth_hash)
      result = PersonService.sign_up_by_oauth(auth_hash)
      return nil unless result.succeeded?
      result.person_id
    end

    def auth_hash
      request.env['omniauth.auth']
    end
end
