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
  # This would pull up all 20 million questions and sort them
  all.sort_by { |question| question.total_votes }.reverse[0..19]
end

def self.get_questions_by_trending
  Question.joins(:votes).where('votes.created_at > ?', 5.hours.ago).group('questions.id').order('count(votes.id) desc').limit(20)
  # better than
  Question.all.each.sort {|x| x.votes.where("created_at < ?", 5.hours.ago).count}
end

def get_answers_count
  #unnecessary answers.count will give the count

   if (self.answers)
    return (self.answers.count)
  else
    return 0
  end
end

def get_modified_time
  #You could do this with active_record touch
  # Also the name here is a little misleading if you return a string
  answers = self.answers
  if answers != []
    return get_modified_time_string(answers,1)
  else
    return get_modified_time_string(self,2)
  end
end

def get_modified_time_string(compare_to,code)
  # Be careful about using "magic numbers" like code here - what does it mean?
  # Prefer a constant with a meaningful name
  # Also the method name is misleading. It suggests it's reading 
  # modified time, but it's reading created_at
   code == 1 ? (time = (Time.now - compare_to.order(created_at: :desc).first.created_at)) : (time = (Time.now - compare_to.created_at))
    if time/3600 >= 1
      # .floor would probably be better than .round here
      return "#{(time/3600).round} hours ago"
    elsif time/60 >= 1
      return "#{(time/60).round} minutes ago"
    else
      return "#{(time).round} seconds ago"
    end
end




end
