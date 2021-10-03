class MemberAttendancesController < ApplicationController
  wrap_parameters :member_attendance, format: :json
  before_action :authenticate_user!
  before_action :set_member_attendance, only: %i[ show update destroy ]

  def index
    @room = Room.find_by_channel_id params[:channel_id]
    @member_attendances = @room.member_attendances
  end

  def show
  end

  def create
    @member = Member.find_by_chat_id params[:chat_id]
    @member_attendance = MemberAttendance.new(member_attendance_params.reverse_merge(member: @member))
    if @member_attendance.save
      render :show, status: :created
    else
      render json: @member_attendance.errors, status: :unprocessable_entity
    end
  end

  def update
    if @member_attendance.update(member_attendance_params)
      render :show, status: :ok
    else
      render json: @member_attendance.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @member_attendance.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member_attendance
    @member_attendance = MemberAttendance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def member_attendance_params
    params.require(:member_attendance).permit(:due_date)
  end
end
