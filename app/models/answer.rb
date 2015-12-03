class Answer < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :question
  has_one  :best_answer_for_question, class_name: "Question"
  has_many  :votes, as: :votable
  has_many  :comments, as: :commentable
end
