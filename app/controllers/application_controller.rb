class ApplicationController < ActionController::Base
  helper_method :signed_in?

  protected

    def current_user
      @__current_user ||= fetch_user(session[:user_id])
    end

    def signed_in?
      !!current_user
    end

    def fetch_user(user_id = nil)
      return nil unless user_id
      Apps::User.find_by(id: user_id)
    end
end
