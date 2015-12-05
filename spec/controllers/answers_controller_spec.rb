require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:q) {FactoryGirl.create(:question)}
  context "#create" do
    it "will add an answer to the question" do
      expect {
        post :create, question_id: q.id, answer: FactoryGirl.attributes_for(:answer, question: q)
      }.to change(q.answers, :count).by(1)
    end

  end

  context "#new" do
    it "belongs to the question" do
      get :new, {question_id: q.id}
      expect(assigns(:question)).to eq(q)
    end
  end


end
