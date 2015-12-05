require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has email' do
    u = User.new
    expect(u).to respond_to(:email)
  end

  context "validations" do
    it { should validate_presence_of :email }
    it { should allow_value('laura@devbootcamp.com').for(:email) }
    it { should_not allow_value('badlyFormattedEmail').for(:email) }
    it {should validate_length_of(:password).is_at_least(6).on(:create)}
    it {should validate_length_of(:password).is_at_most(20).on(:create)}
  end
end
