class Question < ActiveRecord::Base
  include Voting

  belongs_to  :user
  has_many    :answers
  belongs_to  :best_answer, class_name: "Answer", foreign_key: :answer_id
  has_many    :votes, as: :votable
  has_many    :comments, as: :commentable

  validates :title, :content, presence: true


def self.get_questions_by_newest
  order(created_at: :desc).limit(20)
end

def self.get_questions_by_highest_voted
  all.sort_by { |question| question.total_votes }.reverse[0..19]
end

def self.get_questions_by_trending
  Vote.all.where("updated_at > ? AND votable_type = ?", 5.hours.ago, "Question").group("votable_id, id")
end

def get_answers_count
   if (self.answers)
    return (self.answers.count)
  else
    return 0
  end
end

def get_modified_time
  answers = self.answers
  if answers != []
    return get_modified_time_string(answers,1)
  else
    return get_modified_time_string(self,2)
  end
end


def get_modified_time_string(compare_to,code)
   code == 1 ? (time = (Time.now - compare_to.order(created_at: :desc).first.created_at)) : (time = (Time.now - compare_to.created_at))
    if time/3600 >= 1
      return "#{(time/3600).round} hours ago"
    elsif time/60 >= 1
      return "#{(time/60).round} minutes ago"
    else
      return "#{(time).round} seconds ago"
    end
end




end
