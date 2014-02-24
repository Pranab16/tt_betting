require 'spec_helper'

describe AuthenticationController do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "GET #login" do
    it "renders the login view" do
      get :login
      response.should render_template :login
    end

    it "redirects to root" do
      session[:user_id] = @user.id
      get :login
      response.should redirect_to :root
    end

  end

  describe "POST #authenticate" do
    context "with invalid credentials" do
      it "re-renders the login action" do
        post :authenticate, user: {username: @user.username, password: 'wrong'}
        response.should render_template :login
        session[:user_id].should eq(nil)
      end
    end

    context "with valid credentials" do
      it "redirects to root" do
        post :authenticate, user: {username: @user.username, password: @user.password}
        response.should redirect_to :root
        session[:user_id].should eq(@user.id)
      end
    end
  end

  describe "GET #logout" do
    it "requires login" do
      get :logout
      response.should redirect_to :login
      flash[:error].should eq('This page requires login.')
    end

    it "redirects to login" do
      session[:user_id] = @user.id
      get :logout
      response.should redirect_to :login
      flash[:success].should eq('Successfully logged out.')
    end

  end

  describe "GET #signup" do
    it "renders the signup view" do
      get :signup
      response.should render_template :signup
    end
  end

  describe "POST create user" do
    context "with existing data" do
      it "re-renders the signup action" do
        post :create_user, user: FactoryGirl.attributes_for(:user)
        response.should render_template :signup
        session[:user_id].should eq(nil)
      end
    end

    context "with invalid email format" do
      it "re-renders the signup action" do
        post :create_user, user: FactoryGirl.attributes_for(:user, email: 'wrong_email')
        response.should render_template :signup
        session[:user_id].should eq(nil)
      end
    end

    context "with valid data" do
      it "redirects to root" do
        post :create_user, user: FactoryGirl.attributes_for(:user, username: 'test_1')
        response.should redirect_to :root
        session[:user_id].should_not eq(nil)
      end
    end
  end

end