FactoryGirl.define do
  factory :user do
    first_name {"User"}
    last_name {"MyString"}
    email {"fake@gmail.com"}
    password_digest {"password"}
  end
end
