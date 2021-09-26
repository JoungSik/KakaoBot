class Fortune < ApplicationRecord
  validates :name, uniqueness: { scope: :due_date }
  validates_presence_of :name, :content, :due_date

  scope :find_by_name_with_today, -> (name) { where(name: name, due_date: Date.today).first }
end
