Factory.sequence :category_name do |n|
  "Category-#{n}"
end

Factory.define :video_category do |f|
  f.name { Factory.next(:category_name) }
end
