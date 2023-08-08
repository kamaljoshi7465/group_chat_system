class Seat < ApplicationRecord
  belongs_to :property
  has_many :bookings, dependent: :destroy
end
