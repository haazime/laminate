class PagesController < ApplicationController
  helper_method :current_user

  def show
    render params[:id]
  end

  def current_user
    OpenStruct.new(
      name: '末吉 哉',
      initials: 'HS',
      hex_color: '#ffd7ad'
    )
  end
end
