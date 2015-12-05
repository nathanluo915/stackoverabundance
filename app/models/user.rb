class User < ActiveRecord::Base
  has_secure_password

  has_many  :questions
  has_many  :answers
  has_many  :comments
  has_many  :votes

validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def voted_for?(votable)
    Vote.where(votable: votable, user: self).count > 0
  end

  def upvoted?(votable)
    Vote.find_by(votable: votable, user: self).upvote if self.voted_for?(votable)
  end
end
