class MemberAttendance < ApplicationRecord
  belongs_to :member

  validates :due_date, presence: true, uniqueness: { scope: :member }
end
