class PagesController < ApplicationController
  helper_method :current_user

  def show
    page_id = params[:id]
    set_current_user(page_id)
    render page_id
  end

  def set_current_user(page_id)
    return if %w(sign_in).include?(page_id)
    @current_user =
      OpenStruct.new(
        name: '末吉 哉',
        initials: 'HS',
        hex_color: '#ffd7ad'
      )
  end

  def current_user
    @current_user
  end
end
