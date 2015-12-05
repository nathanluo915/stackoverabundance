FactoryGirl.define do

  factory :comment do
    content Faker::Lorem.paragraph
    association :user, factory: :user

    factory :answer_comment do
      association :commentable, :factory => :answer
    end

    factory :question_comment do
      association :commentable, :factory => :question
    end
  end
end
