class Vote < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :votable, polymorphic: true

  validates :user, uniqueness: { scope: [:votable_type, :votable_id],
    message: "You may only vote once per question. If you are seeing this message, you have attempted vote manipulation, which is against our community guidelines. If you believe you are seeing this message by mistake, please contact our team at admin@stackoverabundance.com to prevent your account from being banned."}

  def self.your_vote(current_user, votable)
    Vote.find_by(user: current_user, votable: votable)
  end

end
