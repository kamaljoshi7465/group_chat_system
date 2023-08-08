FactoryBot.define do
    factory :meeting_room do
      name { Faker::Name.name }
      capacity { Faker::Number.between(from: 5, to: 50) }
      booking_status { ['Available', 'Booked'].sample }
      association :property, factory: :property
    end
  end