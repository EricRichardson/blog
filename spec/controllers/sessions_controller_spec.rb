require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  def create_user
    @user = FactoryGirl.build(:user)
    @user.password = "1234"
    @user.save
  end


  def log_in
    user = User.first
    request.session[:user_id] = user.id
  end

  describe "#new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    before {create_user; log_in}

    context "with correct credentials" do
      it "should log in the user"

      it "should display a flash message" do
        post :create, {email: "fake@gmail.com", password: "1234"}
        expect(flash[:notice]).to be
      end
    end

    context "with incorrect credentials" do
      it "should not log in the user"

      it "should increment the failed_attempts count" do
        fails_before = @user.failed_attempts
        post :create, {email: "fake@gmail.com", password: "12"}
        fails_after = @user.reload.failed_attempts
        expect(fails_after).to eq (fails_before+1)
      end

      it "should lock out the user after repeated attempts" do
        12.times {post :create, {email: "fake@gmail.com", password: "12"}}
        post :create, {email: "fake@gmail.com", password: "1234"}
        expect(response).to render_template(:new)
      end
    end
  end
end
