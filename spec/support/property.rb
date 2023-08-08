FactoryBot.define do
	factory :property do
		name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    property_type { ['Apartment', 'House', 'Villa', 'Condo'].sample }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    address { Faker::Address.street_address }
    location_link { Faker::Internet.url }
    amenities { Faker::Lorem.words(number: 5).join(', ') }
    floor_plan_images { { url: Faker::Internet.url } }
    property_images { { url: Faker::Internet.url } }
	end
end