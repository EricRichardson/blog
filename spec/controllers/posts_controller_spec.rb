require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  def create_post
    Post.create(FactoryGirl.attributes_for(:post))
  end

  describe "#new" do
    before {get :new}

    it "sets an instance variable to a new post" do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid params" do
      def valid_post
        post :create, post: FactoryGirl.attributes_for(:post)
      end

      it "should save the post" do
        count_before = Post.count
        valid_post
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end

      it "should redirect to show post" do
        valid_post
        expect(response).to redirect_to(post_path(Post.last.id))
      end
    end

    context "with invalid params" do
      def invalid_post
        post :create, post: {title: ''}
      end

      it "should not make the post" do
        count_before = Post.count
        invalid_post
        count_after = Post.count
        expect(count_before).to eq(count_after)
      end

      it "should render new" do
        invalid_post
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    before do
      create_post
      get :show, id: Post.last.id
    end

    it "should initialize a variable according to passed id" do
      expect(assigns(:post)).to eq(Post.last)
    end

    it "should render the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#index" do
    before do
      @p1 = create_post
      @p2 = create_post
      get :index
    end

    it "instantiates a variable of the posts" do
      expect(assigns(:posts)).to eq([@p2, @p1])
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end

  describe "#edit" do
    before do
      create_post
      get :edit, id: Post.last.id
    end

    it "instantiates a variable according to passed id" do
      expect(assigns(:post)).to eq(Post.last)
    end

    it "should render the edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do

    def post
      @post ||= Post.create FactoryGirl.attributes_for(:post)
    end
    context "with valid params" do

      it "should update the post" do
        patch :update, id: post.id, post: {title: "new"}
        expect(Post.last.title).to eq("new")
      end

      it "should redirect to show" do
        patch :update, id: post.id, post: {title: "new"}
        expect(response).to redirect_to(post_path(post))
      end
    end

    context "with invalid params" do
      it "should not update the post" do
        patch :update, id: post.id, post: {title: ""}
        expect(Post.last.title).to_not eq('')
      end

      it "should render edit" do
        patch :update, id: post.id, post: {title: ""}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    before {create_post}
    it "should destroy the post" do
      count_before = Post.count
      delete :destroy, id: Post.last.id
      count_after = Post.count
      expect(count_before).to eq(count_after + 1)
    end

    it "should redirect to index" do
      delete :destroy, id: Post.last.id
      expect(response).to redirect_to(posts_path)
    end
  end
end
