require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "Adding record" do
    it "sucess if all parameters are valid" do
      answer = FactoryGirl.create(:answer)
      expect(answer.persisted?).to eq(true)
    end

    it "fail if the user does not exist" do
      answer = Answer.new(content: "HiHi", question: FactoryGirl.create(:question), user_id: 99)
      expect(answer.valid?).to eq(false)
    end

    it "fail if the question does not exist" do
      a = Answer.new(content: "HiHi", user: FactoryGirl.create(:user))
      expect(a.valid?).to eq false
    end

    it "fail if the content is nil or empty" do
      expect{FactoryGirl.create(:answer, content: nil)}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Content cannot be empty')
      expect{FactoryGirl.create(:answer, content: "")}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Content cannot be empty')
    end
  end

  context "Association" do
    it "should return the user who created the answer" do
      user = FactoryGirl.create(:user)
      answer = FactoryGirl.create(:answer, user: user)
      expect(answer.user).to eq(user)
    end

    it "should return the question it belongs to" do
      question = FactoryGirl.create(:question)
      answer = FactoryGirl.create(:answer, question: question)
      expect(answer.question).to eq(question)
    end

    it "should return a collection of comments it has" do
      answer = FactoryGirl.create(:answer)
      3.times do
        comments << FactoryGirl.create(:answer_comment, commentable: answer)
      end
      3.times {FactoryGirl.create(:answer_comment, commentable: answer)}

      expect(answer.comments).to eq(comments)
    end
  end

end
