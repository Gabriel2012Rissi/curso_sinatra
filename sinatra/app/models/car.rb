class Car < ActiveRecord::Base
  # Validations
  validates :brand, :model, presence: true
  validates :year,
    numericality: { greater_than: 1990, less_than_or_equal_to: Date.today.year },
    presence: true
  validates :price, presence: true
end