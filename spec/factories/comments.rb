FactoryGirl.define do
  factory :answer_comment, class: "Comment" do
    content Faker::Lorem.paragraph
    association :commentable, :factory => :answer
    association :user, factory: :user
  end

  factory :question_comment, class: "Question" do
    content Faker::Lorem.paragraph
    association :commentable, :factory => :question
    association :user, factory: :user
  end
end
