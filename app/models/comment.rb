class Comment < ActiveRecord::Base
  include Voting

  belongs_to  :commentable, polymorphic: true
  belongs_to  :user
  has_many    :votes, as: :votable

  validates :content, :commentable, :user, presence: true
  before_save :validate_empty_content


  private
  def validate_empty_content
    unless content && content.length > 0
      errors.add(:content, "Content cannot be empty")
    end
  end
end
