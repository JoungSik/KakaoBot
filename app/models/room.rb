class Room < ApplicationRecord
  belongs_to :client

  has_many :members
  has_many :member_attendances, -> { where(due_date: Date.today).order(created_at: :asc) },
           through: :members, source: :attendances

  validates_presence_of :name, :channel_id, :channel_type
  validates_uniqueness_of :name, :channel_id
end
