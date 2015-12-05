require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "Answer" do
    it "add a new record to database if all parameters are valid" do
      answer = FactoryGirl.create(:answer)
      expect(answer.id).to_not eq(nil)
    end
  end

end
