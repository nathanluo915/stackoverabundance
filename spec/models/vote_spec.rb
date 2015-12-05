require 'rails_helper'

RSpec.describe Vote, type: :model do
  before(:each) do
    vote1 = Vote.create(user_id: 1, votable:)
  end


  it "should be true by default" do

  end

  it "should have a user id" do
    pending
  end

  it "should be associated with a question, answer, or comment" do
    pending
  end

  it "One user should not be able to vote twice" do
    pending
  end
end
