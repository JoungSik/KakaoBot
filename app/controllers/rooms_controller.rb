class RoomsController < ApplicationController
  wrap_parameters :room, format: :json
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show update destroy ]

  def index
    @rooms = current_user.rooms
  end

  def show
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render :show, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render :show, status: :ok
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find_by_channel_id params[:id]
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :channel_id, :channel_type, :notice, :client_id)
  end
end
