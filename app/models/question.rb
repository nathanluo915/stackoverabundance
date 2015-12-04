class Question < ActiveRecord::Base
  include Voting

  belongs_to  :user
  has_many    :answers
  belongs_to  :best_answer, class_name:  "Answer"
  has_many    :votes, as: :votable
  has_many    :comments, as: :commentable
end
