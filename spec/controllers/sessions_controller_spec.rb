require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context "new" do
    it "is successful" do
      get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    let(:user) { FactoryGirl.create :user }
    it "redirects to root path if correct credentials" do
      post :create, :email => user.email, :password => user.password
      expect(response).to redirect_to root_path
    end

    it "re-renders form if incorrect email" do
      post :create, :email => "wrong@email.com", :password => user.password
      expect(response).to redirect_to login_path
    end
    it "re-renders form if incorrect password" do
      post :create, :email => user.email, :password => '124455'
      expect(response).to redirect_to login_path
    end
  end

  context '#delete' do
    let(:user) { FactoryGirl.create :user }
    it 'redirects to root path after user logs out' do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end
