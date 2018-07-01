class PagesController < ApplicationController

  def show
    page_id = params[:id]
    render page_id
  end
end
