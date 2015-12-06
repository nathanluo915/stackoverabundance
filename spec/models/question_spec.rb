require 'rails_helper'

RSpec.describe Question, type: :model do

  it "is valid with a title and content" do
    q = Question.new(title: "asdf", content: "asdf")
    expect(q).to be_valid
  end

  it "is invalid without a title but with content" do
    q = Question.new(content: "asdf")
    q.valid?
    expect(q.errors[:title]).to include "can't be blank"
  end

  it "is invalid with a title but without content" do
    q = Question.new(title: "adf")
    q.valid?
    expect(q.errors[:content]).to include "can't be blank"
  end


end
