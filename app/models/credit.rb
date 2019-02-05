class Credit < ApplicationRecord
  belongs_to: user
  validates :card_number, presence: true, uniqueness: true
  validates :expiration_month, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :expiration_year, presence: true, numericality: { only_integer: true }
  validates :security_code, presence: true, uniqueness: true
end
