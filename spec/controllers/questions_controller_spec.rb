require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  before do
    session[:user_id] = user.id
  end

  describe "Get #index" do
    it "Will bring up a list of questions on the index page" do
    get :list
    expect(response).to render_template :_questions
  end
end

  describe "Post #new" do
    it "Saves a new question in the database if user is logged in" do
      expect {
        post :create, question: FactoryGirl.attributes_for(:question)}.to change(Question, :count).by(1)
    end
end





end
