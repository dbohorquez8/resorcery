FactoryGirl.define do
  sequence :uid do |n|
    "TX#{n}"
  end

  sequence :email, 1000 do |n|
    "something.#{n}@gmail.com"
  end
end
