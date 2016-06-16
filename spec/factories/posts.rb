FactoryGirl.define do
  factory :post do
    title { Faker::Hipster.sentence }
    body { Faker::Hipster.paragraph }
    category {Category.all.sample}
  end
end
