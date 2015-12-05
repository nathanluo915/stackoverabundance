FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence.sub(/\./, "?")
    content Faker::Lorem.paragraph
    user
  end

end
