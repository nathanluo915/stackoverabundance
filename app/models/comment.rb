class Comment < ActiveRecord::Base
  include Voting

  belongs_to  :commentable, polymorphic: true
  belongs_to  :user
  has_many    :votes, as: :votable

  validates :content, :commentable, :user, presence: true
  validate :empty_content


  private
  def empty_content
    unless content && content != ""
      errors.add(:content, "cannot be empty")
    end
  end
end
