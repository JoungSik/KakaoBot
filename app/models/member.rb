class Member < ApplicationRecord
  belongs_to :room

  has_many :attendances, foreign_key: :member_id, class_name: 'MemberAttendance', dependent: :destroy

  validates :name, presence: true
  validates :chat_id, presence: true, uniqueness: { scope: :room }
end
