Factory.define :user do |f|
  f.password '123456'
  f.password_confirmation {|proxy| proxy.password}
  f.email { |proxy|
    e = Faker::Internet.email
    until User.find_by_email(e).nil?
      e = Faker::Intenet.email
    end
    e
  }
end

