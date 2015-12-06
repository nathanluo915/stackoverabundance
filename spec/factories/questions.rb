FactoryGirl.define do

  factory :question do
    title {Faker::Company.catch_phrase}
    content {Faker::Hipster.paragraph}
    association :user, factory: :user
  end

end
