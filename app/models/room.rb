class Room < ApplicationRecord
  belongs_to :client

  has_many :notices
  accepts_nested_attributes_for :notices, allow_destroy: true

  has_many :members
  has_many :member_attendances,
           -> {
             select('ROW_NUMBER() OVER(ORDER BY member_attendances.created_at ASC) as order, name, member_attendances.*')
               .where(due_date: Date.today).order(created_at: :asc)
           },
           through: :members, source: :attendances

  has_many :ban_keywords

  validates_presence_of :name, :channel_id, :channel_type
  validates_uniqueness_of :name, :channel_id
end
