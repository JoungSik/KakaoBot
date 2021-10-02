class BanKeyword < ApplicationRecord
  belongs_to :room

  validates :name, presence: true, uniqueness: { scope: :room }
  validates :word, presence: true, uniqueness: { scope: :room }
  validates :category, presence: true

  enum category: { link: 0 }
end
