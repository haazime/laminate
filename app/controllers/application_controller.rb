class ApplicationController < ActionController::Base
  include SignInHelper
  include UserGuard

  helper_method :signed_in?, :current_user
end
