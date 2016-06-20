require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  def create_user
    User.create(FactoryGirl.attributes_for(:user))
  end

  def log_in
    user = User.first
    request.session[:user_id] = user.id
  end

  describe '#new' do
    it "should render new template" do
    get :new
    expect(response).to render_template(:new)
    end
  end
end
