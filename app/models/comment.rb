class Comment < ActiveRecord::Base
  include Voting

  belongs_to  :commentable, polymorphic: true
  belongs_to  :user
  has_many    :votes, as: :votable

  validates :content, :commentable, :user, presence: true
  validate :empty_content

 
  private
  # This is unnecessary and repeated in >1 model. 
  # Shared stuff make a concern, but in this case a built-in validation would work anyway
  def empty_content
    unless content && content != ""
      errors.add(:content, "cannot be empty")
    end
  end
end
