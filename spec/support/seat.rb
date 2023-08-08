FactoryBot.define do
  factory :seat do
    capacity { Faker::Number.between(from: 1, to: 5) }
    seat_name { Faker::Lorem.word }
    booking_status { ['Available', 'Booked'].sample }
    association :property, factory: :property
  end
end