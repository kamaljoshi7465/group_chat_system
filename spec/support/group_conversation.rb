FactoryBot.define do
  factory :group_conversation do
    name { Faker::Name.name }
    icon { "img.png" }
    description { Faker::Lorem.sentence }
    user_ids { [create(:user).id, create(:user).id] }
  end
end