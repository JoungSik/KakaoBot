class Room < ApplicationRecord
  belongs_to :client

  validates_presence_of :name, :channel_id, :channel_type
  validates_uniqueness_of :name, :channel_id
end
