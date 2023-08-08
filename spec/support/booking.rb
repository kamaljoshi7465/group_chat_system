FactoryBot.define do
	factory :booking do
		association :property
		association :meeting_room
		association :seat
		booking_date { "26/07/2023" }
		time_slot { "01pm-05pm" } 
		association :user
	end
end