class MemberAttendance < ApplicationRecord
  belongs_to :member

  validates :due_date, presence: true, uniqueness: { scope: :member }

  def self.order_number(due_date, member_attendance)
    orders = MemberAttendance.where(due_date: due_date).order(created_at: :asc)
    orders.index(member_attendance) + 1
  end
end
