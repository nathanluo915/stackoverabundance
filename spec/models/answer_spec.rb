require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "Answer" do
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
        answer = Answer.new(content: "HiHi", question_id: 1, user: FactoryGirl.create(:user))
        expect(answer.valid?).to eq(false)
      end

      it "fail if the content is nil or empty" do
        expect{FactoryGirl.create(:answer, content: nil)}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Content cannot be empty')
        expect{FactoryGirl.create(:answer, content: "")}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Content cannot be empty')
      end
    end
  end

end
