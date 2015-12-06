class User < ActiveRecord::Base
  has_secure_password

  has_many  :questions
  has_many  :answers
  has_many  :comments
  has_many  :votes

  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password, length: { in: 6..20 }


  def voted_for?(votable)
    Vote.where(votable: votable, user: self).count > 0
  end

  def upvoted?(votable)
    Vote.find_by(votable: votable, user: self).upvote if self.voted_for?(votable)
  end

  def reputation

    self.questions_scores + self.answers_scores + self.comments_scores
  end

  def questions_scores
    self.questions.map{|q| q.total_votes.to_i}.reduce(:+) || 0
  end
  def answers_scores
    self.answers.map{|q| q.total_votes.to_i}.reduce(:+) || 0
  end
  def comments_scores
    self.comments.map{|q| q.total_votes.to_i}.reduce(:+) || 0
  end
end
