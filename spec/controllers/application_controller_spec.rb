require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }

  describe "logged_in? helper" do
   context "with user logged in" do
    before do
      session[:user_id] = user.id
    end

    it "returns true" do
      expect(controller.send(:logged_in?)).to be true
    end
   end

    context "without user logged in" do
      it "returns false" do
        expect(controller.send(:logged_in?)).to be false
      end
    end
  end

 #  describe '#current_user' do
 #    context 'with user logged in' do
 #    before do
 #     sign_in_via_facebook(user)
 #     get :index
 #   end
 #   it 'assigns the current_user' do
 #     expect(assigns(:current_user)).to eq(user)
 #   end     end

 #   context 'without user logged in' do

 #     it 'current_user be nil' do
 #       get :index
 #       expect(assigns(:current_user)).to be_nil
 #     end
 #   end

 #   context "can't find the user" do
 #    before do
 #     session[:user_id] = '#77'
 #     get :index
 #   end

 #   it 'current_user be nil' do
 #     expect(assigns(:current_user)).to be_nil
 #   end

 #   it 'unsets the session[:user_id]' do
 #     expect(session[:user_id]).to be_nil
 #   end
 # end
end
