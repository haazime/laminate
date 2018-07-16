class ApplicationController < ActionController::Base
  include SignInHelper
  include SignInGuard

  helper_method :signed_in?, :current_person
end
