class MemberAttendance < ApplicationRecord
  belongs_to :member

  validates :due_date, presence: true, uniqueness: { scope: :member }

  def member_name
    try(:name) ? name : member.name
  end

  def order_number
    try(:order) ? order : member.room.member_attendances.index(self) + 1
  end
end
