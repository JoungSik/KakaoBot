class Notice < ApplicationRecord
  belongs_to :room

  validates :category, presence: true
  validates :content, presence: true
end
