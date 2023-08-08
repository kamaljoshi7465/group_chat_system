FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    association :user
    association :group_conversation
  end
end

