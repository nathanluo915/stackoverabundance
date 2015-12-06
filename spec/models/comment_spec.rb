require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "Adding record" do
    it "sucess if all parameters are valid" do
      answer_comment = FactoryGirl.create(:answer_comment)
      expect(answer_comment.persisted?).to eq(true)
    end

    it "fail if the user does not exist" do
      comment = Comment.new(content: "HiHi", commentable: FactoryGirl.create(:answer), user_id: User.last.id + 1)
      expect(comment.valid?).to eq(false)
    end

    it "fail if the commentable does not exist" do
      a = Answer.new
      comment = Comment.new(content: "HiHi", user: FactoryGirl.create(:user))
      expect(comment.valid?).to eq(false)
    end

    it { should_not allow_value(nil).for(:content) }
    it { should_not allow_value('').for(:content) }
  end

  context "association" do
    it "should return the user who created the answer" do
      user = FactoryGirl.create(:user)
      comment = FactoryGirl.create(:answer_comment, user: user)
      expect(comment.user).to eq(user)
    end

    it "should return the question it belongs to" do
      question = FactoryGirl.create(:question)
      comment = FactoryGirl.create(:question_comment, commentable: question)
      expect(comment.commentable).to eq(question)
    end

    it "should return the answer it belongs to" do
      answer = FactoryGirl.create(:answer)
      comment = FactoryGirl.create(:answer_comment, commentable: answer)
      expect(comment.commentable).to eq(answer)
    end

  end

end
