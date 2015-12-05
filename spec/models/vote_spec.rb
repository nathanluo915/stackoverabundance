require 'rails_helper'

RSpec.describe Vote, type: :model do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @question = FactoryGirl.create(:question, user: @user)
    @vote1 = Vote.create(user: @user, votable: @question)
    @answer = FactoryGirl.create(:answer, user: @user)
  end
  it "should be true by default" do
    expect(@vote1.upvote).to eq(true)
  end

  it "should have an accurate user id" do
    expect(@vote1.user_id).to eq(@user.id)
  end

  it "should be associated with the correct question, answer, or comment" do
    expect(@vote1.votable_id).to eq(@question.id)
    expect(@vote1.votable_type).to eq("Question")
    answer = FactoryGirl.create(:answer, user: @user)
    vote2 = Vote.create(user: @user, votable: answer)
    expect(vote2.votable_id).to eq(answer.id)
    expect(vote2.votable_type).to eq("Answer")
    comment = FactoryGirl.create(:answer_comment, commentable: answer, user: @user)
    vote3 = Vote.create(user: @user, votable: comment)
    expect(vote3.votable_id).to eq(comment.id)
    expect(vote3.votable_type).to eq("Comment")
  end

  it "One user should not be able to vote twice" do
    bad_vote = Vote.new(user: @user, votable: @question)
    expect(bad_vote).to_not be_valid
  end
end
