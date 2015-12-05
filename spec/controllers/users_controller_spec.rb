require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "#new" do
    it 'is successful' do
      get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    it 'should create a new user' do
      expect{
      post :create, user: FactoryGirl.attributes_for(:user)}.to change(User, :count).by(1)
    end

    it 'should redirect to the homepage if user was successfully created' do
      user = FactoryGirl.attributes_for(:user)
      post :create, user:user
      expect(response).to redirect_to root_path
    end

    it 'should redirect to the sign up path if user was not created' do
      user = FactoryGirl.create(:user)
      post :create, user: {username:user.username,email:"me", password:user.password }
      expect(response).to redirect_to signup_path
     end
  end

  context "#show" do
    it 'should show a users profile' do
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end
  end

  context "#edit" do
    it 'is successful' do
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(response).to be_success
    end

    it 'should update user info with valid params' do
      user = FactoryGirl.create(:user)
      old_attr = user.attributes
      expect{
        put :update, id: user.id, user:{about: "Cool dude"}
        }.to change{user.reload.about}.from(old_attr['about']).to("Cool dude")
    end
  end

  context "#destoy" do
    it 'should destroy the users profile' do
      user = FactoryGirl.create(:user)
      expect{
        delete :destroy, id: user.id
      }.to change(User, :count).by(-1)
    end
  end
end
