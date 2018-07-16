module SignInGuard
  include SignInHelper

  protected

    def ensure_signed_in
      unless signed_in?
        redirect_to new_session_url, notice: t('navs.ensure_signed_in')
      end
    end

    def ensure_signed_out
      if signed_in?
        redirect_to root_url, notice: t('navs.already_signed_in')
      end
    end
end
