FactoryGirl.define do
  factory :question_vote, class: "Vote" do
    association :user, factory: :user
    association :votable, factory: :question
    upvote  true
  end

  factory :answer_vote, class: "Vote" do
    association :user, factory: :user
    association :votable, factory: :answer
    upvote  true
  end

  factory :comment_vote, class: "Vote" do
    association :user, factory: :user
    association :votable, factory: :comment
    upvote  true
  end

end
