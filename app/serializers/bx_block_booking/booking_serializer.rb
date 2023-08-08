module BxBlockBooking
  class BookingSerializer < ActiveModel::Serializer
    attributes :id, :booking_date, :time_slot, :property_type, :meeting_room_name, :seat_name

    def property_type
      object.property.property_type
    end

    def meeting_room_name
      object.meeting_room.name
    end

    def seat_name
      object.seat.seat_name
    end
  end
end