class Room < ApplicationRecord
  belongs_to :client

  has_many :members
  has_many :member_attendances, through: :members, source: :attendances

  validates_presence_of :name, :channel_id, :channel_type
  validates_uniqueness_of :name, :channel_id
end
