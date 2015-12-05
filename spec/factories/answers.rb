FactoryGirl.define do
  factory :answer do
    content Faker::Lorem.paragraph
    user
    question
  end
end
