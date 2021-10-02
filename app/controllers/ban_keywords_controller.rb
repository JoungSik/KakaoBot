class BanKeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.find_by_channel_id params[:channel_id]
    @ban_keywords = @room.ban_keywords.find_all { |x| params[:text].match(x.word) }
  end
end
