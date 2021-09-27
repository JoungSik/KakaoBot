class MembersController < ApplicationController
  wrap_parameters :member, format: :json
  before_action :authenticate_user!
  before_action :set_member, only: %i[ show update destroy ]

  def index
    @room = Room.find_by_channel_id params[:channel_id]
    @members = @room.members
  end

  def show
  end

  def create
    @room = Room.find_by_channel_id params[:channel_id]
    @member = Member.new(member_params.reverse_merge(room: @room))
    if @member.save
      render :show, status: :created
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def update
    if @member.update(member_params)
      render :show, status: :ok
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:name, :chat_id)
  end
end
