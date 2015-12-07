require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "Get #index" do
    it "Will bring up a list of questions on the index page" do
    get :list
    expect(response).to render_template :_questions
  end
end

  describe "Post #new" do
    it "Saves a new question in the database if user is populated" do
      expect {
        post :create, question: FactoryGirl.attributes_for(:question)}.to change(Question, :count).by(1)
    end
    it "Does not save a new question in the database if user is not populated" do
      expect {
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
        post :create, question: FactoryGirl.attributes_for(:question)}.to_not change(Question, :count)
    end

  end
end
