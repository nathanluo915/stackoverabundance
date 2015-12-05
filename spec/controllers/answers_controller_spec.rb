require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:q) {FactoryGirl.create(:question)}
  before do
    session[:user_id] = user.id
  end

  context "#create" do
    it "will add an answer to the question" do
      expect {
        post :create, question_id: q.id, answer: {content: "Actual Content"}
      }.to change(q.answers, :count).by(1)
    end

    it "will not add an answer to the question if content is empty" do
      expect{
        post :create, question_id: q.id, answer: FactoryGirl.attributes_for(:answer, question: q, content: "")
      }.to_not change(q.answers, :count)
    end


  end

  context "#new" do
    it "belongs to the question" do
      get :new, {question_id: q.id}
      expect(assigns(:question)).to eq(q)
    end
  end


end
