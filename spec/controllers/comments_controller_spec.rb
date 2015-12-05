require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:q) {FactoryGirl.create(:question)}
  let(:a) {FactoryGirl.create(:answer)}

  before do
    session[:user_id] = user.id
  end

  context "#create" do
    context "question comment" do
      it "will add a comment to the question" do
        expect {
          post :create, vote: {content: "Actual Content", commentable_id: q.id, commentable_type: q.class}
        }.to change(q.comments, :count).by(1)
      end

    end

    # it "will not add an answer to the question if content is empty" do
    #   expect{
    #     post :create, question_id: q.id, answer: FactoryGirl.attributes_for(:answer, question: q, content: "")
    #   }.to_not change(q.answers, :count)
    # end

  end



end
