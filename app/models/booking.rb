class Booking < ApplicationRecord
  belongs_to :property
  belongs_to :meeting_room
  belongs_to :seat
  belongs_to :user
end
