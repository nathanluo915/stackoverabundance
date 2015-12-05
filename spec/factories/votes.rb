FactoryGirl.define do

  factory :vote do
    upvote  true
    association :user, factory: :user

    factory :question_vote do
      association :votable, factory: :question
    end

    factory :answer_vote do
      association :votable, factory: :answer
    end

    factory :comment_vote do
      association :votable, factory: :comment
    end
  end
end
