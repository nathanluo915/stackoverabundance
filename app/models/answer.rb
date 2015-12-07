class Answer < ActiveRecord::Base
  include Voting

  belongs_to  :user
  belongs_to  :question
  has_many  :votes, as: :votable
  has_many  :comments, as: :commentable

  validates :user, :question, presence: true
  # This validation is badly named. You should validate is_good rather than is_bad
  validate :empty_content

  # DRY this in some shared module
  # Also, this formatting is probably view only 
  # so just make it a view helper
  def get_modified_time
    time = (Time.now - self.created_at)
    if time/3600 >= 1
      return "#{(time/3600).round} hours ago"
    elsif time/60 >= 1
      return "#{(time/60).round} minutes ago"
    else
      return "#{(time).round} seconds ago"
    end
end

  private
  # unnecessary? validates_presence_of should do this?
  def empty_content
    unless content && content != ""
      errors.add(:content, "cannot be empty")
    end
  end
end
