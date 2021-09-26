class Fortune < ApplicationRecord
  validates :name, uniqueness: { scope: :due_date }
  validates_presence_of :name, :content, :due_date
end
