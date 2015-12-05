FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence.sub(/\./, "?")
    content Faker::Lorem.paragraph
    association :user, factory: :user
  end
end
