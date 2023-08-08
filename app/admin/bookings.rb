ActiveAdmin.register Booking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :property_id, :meeting_room_id, :seat_id, :booking_date, :time_slot, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:property_id, :meeting_room_id, :seat_id, :booking_date, :time_slot, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
