class Answer < ActiveRecord::Base
  include Voting

  belongs_to  :user
  belongs_to  :question
  has_one  :best_answer_for_question, class_name: "Question"
  has_many  :votes, as: :votable
  has_many  :comments, as: :commentable
  before_save :validate_empty_content


  private
  def validate_empty_content
    unless content && content != ""
      errors.add(:content, "Content cannot be empty")
    end
  end
end
