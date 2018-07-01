module UserGuard
  include SignInHelper

  protected

    def require_user
      unless signed_in?
        redirect_to new_session_url, notice: t('navs.require_user')
      end
    end

    def require_guest
      if signed_in?
        redirect_to root_url, notice: t('navs.already_signed_in')
      end
    end
end
