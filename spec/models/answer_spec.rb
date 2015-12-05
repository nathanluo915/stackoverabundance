require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "Answer" do
    context "Adding record" do
      it "sucess if all parameters are valid" do
        answer = FactoryGirl.create(:answer)
        expect(answer.persisted?).to eq(true)
      end

      it "fails if the user does not exist" do
        # answer = FactoryGirl.create(:answer)
        # expect(answer.valid?).to eq(false)
      end
    end
  end

end
