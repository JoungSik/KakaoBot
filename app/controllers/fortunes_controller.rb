class FortunesController < ApplicationController
  before_action :authenticate_user!

  def index
    @fortune = Fortune.find_by_name_with_today params[:name]
  end
end
