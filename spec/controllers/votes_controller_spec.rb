require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  context "#create" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }
    it "creates a vote with valid params" do
      post :create, id: question.id, vote: { user_id: user1.id, votable_id: question.id, votable_type: question.class }
      expect(assigns(:vote).user).to eq(user1)
    end
    it "doesn't create a vote when params are invalid" do
      post :create, id: question.id, vote: {user_id: user1.id, votable_id: question.id, votable_type: question.class }
      bad_vote = Vote.new(user_id: user1.id, votable: question)
      expect(bad_vote).not_to be_valid
    end
  end

  context "#update" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }
    let(:vote) { FactoryGirl.create(:question_vote, user_id: user1.id, votable_id: question.id, votable_type: question.class) }
    let(:old_params) { vote.attributes}
    let(:new_params) { { vote: { upvote: false }}}
    let(:invalid_vote_params) { { vote: { user_id: nil, upvote: false }}}
    it "updates a vote with valid params" do
      expect{
        put :update, id: vote.id, vote: new_params[:vote]
        }.to change {
          vote.reload.upvote
          }.from(old_params["upvote"]).to(new_params[:vote][:upvote])
    end
    it "only changes the vote's upvote field" do
        put :update, id: vote.id, vote: invalid_vote_params[:vote]
          vote.reload.upvote
          expect(vote.user_id).not_to eq(invalid_vote_params[:vote][:upvote])
    end
  end

  let(:vote_to_destroy) { FactoryGirl.create(:question_vote) }

  it "#destroy" do
    get :destroy, id: vote_to_destroy.id
    expect(assigns(:vote_to_destroy)).to eq nil
  end
end
