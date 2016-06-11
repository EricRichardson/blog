require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validations" do

    def invalid_post
      Post.new(title: "", body: "abc")
    end

    it "requires a title" do
      p = invalid_post
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires a body" do
      p = invalid_post
      p.body = ''
      p.valid?
      expect(p.errors).to have_key(:body)
    end

    it "requires a body longer than 6 characters" do
      p = invalid_post
      p.valid?
      expect(p.errors).to have_key(:body)
    end
  end

  describe ".body_snippet" do
    def post
      Post.new(title: "ABC", body: "a"*200)
    end

    it "should display 100 characters" do
      p = post
      expect(p.body_snippet.length).to be(100)
    end

    it "should leave short bodies alone" do
      p = post
      p.body = "a" * 10
      expect(p.body_snippet.length).to be(10)
    end

  end
end
