module SignInHelper
  protected

    def sign_in(user_id)
      return unless user_id
      cookies.signed[:user_id] = user_id
    end

    def sign_out
      cookies.delete(:user_id)
    end

    def current_user
      @__current_user ||= fetch_user(cookies.signed[:user_id])
    end

    def signed_in?
      !!current_user
    end

    def fetch_user(user_id = nil)
      return nil unless user_id
      Apps::User.find_by(id: user_id)
    end
end
