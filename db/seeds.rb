categories = ['Rails', 'Ruby', 'Sports', 'Games', 'Programming', 'Web', 'SQL', 'Electronics', 'Music', 'Art']

categories.each do |cat|
  Category.create title: cat
end

100.times do
  Post.create title: Faker::Hipster.sentence,
              body: Faker::ChuckNorris.fact + Faker::Hipster.paragraph(3),
              category: Category.all.sample
end
