require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:q) {FactoryGirl.create(:question)}
  let(:a) {FactoryGirl.create(:answer, question: q)}

  before do
    session[:user_id] = user.id
  end

  context "#create" do
    context "question comment" do
      it "will add a comment to the question" do
        expect {
          post :create, comment: {content: "Actual Content", commentable_id: q.id, commentable_type: q.class}
        }.to change(q.comments, :count).by(1)
      end

      it "will not add a comment to the question if content is empty" do
        expect{
          post :create, comment: {content: "", commentable_id: q.id, commentable_type: q.class}
        }.to_not change(q.comments, :count)
      end
    end

    context "answer comment" do
      it "will add a comment to the answer" do
        expect {
          post :create, comment: {content: "Actual Content", commentable_id: a.id, commentable_type: a.class}
        }.to change(a.comments, :count).by(1)
      end

      it "will not add a comment to the answer if content is empty" do
        expect{
          post :create, comment: {content: "", commentable_id: a.id, commentable_type: a.class}
        }.to_not change(a.comments, :count)
      end
    end
  end
end
