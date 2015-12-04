class Question < ActiveRecord::Base
  include Voting

  belongs_to  :user
  has_many    :answers
  belongs_to  :best_answer, class_name:  "Answer"
  has_many    :votes, as: :votable
  has_many    :comments, as: :commentable



def self.get_questions_by_newest
  order(created_at: :desc).limit(20)
end

def get_questions_by_

end

def get_votes_count
   if (self.votes && self.votes.find_by(upvote: false))
    return (self.votes.count - self.votes.find_by(upvote: false).count)
  else
    return 0
  end
end

def get_answers_count
   if (self.answers)
    return (self.answers.count)
  else
    return 0
  end
end

end
