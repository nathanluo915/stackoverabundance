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

    it "fail if the content is nil" do
      c = Comment.new(commentable: FactoryGirl.create(:answer), user: FactoryGirl.create(:user))
      expect(c.valid?).to eq(false)
    end
    it "fail if the content is nil" do
      c = Comment.new(commentable: FactoryGirl.create(:answer), user: FactoryGirl.create(:user), content: "")
      expect(c.valid?).to eq(false)
    end
  end

end
