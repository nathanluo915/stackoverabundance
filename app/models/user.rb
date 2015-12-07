class User < ActiveRecord::Base
  has_secure_password

  has_many  :questions
  has_many  :answers
  has_many  :comments
  has_many  :votes

  validates_uniqueness_of :username
  validates_uniqueness_of :email
  #Tiny point but be consistent with spacing in/around { }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password, length: { in: 6..20 }
  validates :password, presence: true

  def voted_for?(votable)
    # votes.where(votable: votable).exists? would also work
    Vote.where(votable: votable, user: self).count > 0
  end

  def upvoted?(votable)
    #You don't need the if here - if the find_by doesn't find it'll return nil
    Vote.find_by(votable: votable, user: self).upvote if self.voted_for?(votable)
  end

  def reputation

    self.questions_scores + self.answers_scores + self.comments_scores
  end

  def questions_scores
    # You could do this in the database.
    # Also reduce(0, :+) will set the zero default if you do reduce
    # but 
    # Question.joins(:votes).where(user:User.first).sum('case when votes.upvote then 1 else -1 end')
    self.questions.map{|q| q.total_votes.to_i}.reduce(:+) || 0
  end
  def answers_scores
    # Answer.joins(:votes).where(user:User.first).sum('case when votes.upvote then 1 else -1 end')
    self.answers.map{|q| q.total_votes.to_i}.reduce(:+) || 0
  end
  def comments_scores
    # Comment.joins(:votes).where(user:User.first).sum('case when votes.upvote then 1 else -1 end')
    self.comments.map{|q| q.total_votes.to_i}.reduce(:+) || 0
  end
end
