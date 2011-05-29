Factory.define :video do |f|
  f.title { Faker::Lorem.sentence }
  f.description { Faker::Lorem.paragraph }
  f.duration { rand(600) + 100 }
  f.category { Factory(:category) }
end
