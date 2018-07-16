module SignInHelper
  KEY = :person_id

  protected

    def sign_in(person_id)
      return unless person_id
      cookies.signed[KEY] = person_id
    end

    def sign_out
      cookies.delete(KEY)
    end

    def current_person
      @__current_person ||= fetch_person(cookies.signed[KEY])
    end

    def signed_in?
      !!current_person
    end

    def fetch_person(person_id = nil)
      return nil unless person_id
      Person::Person.find_by(id: person_id)
    end
end
