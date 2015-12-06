class Answer < ActiveRecord::Base
  include Voting

  belongs_to  :user
  belongs_to  :question
  has_many  :votes, as: :votable
  has_many  :comments, as: :commentable

  validates :user, :question, presence: true
  validate :empty_content


  private
  def empty_content
    unless content && content != ""
      errors.add(:content, "cannot be empty")
    end
  end
end
