FactoryGirl.define do
  factory :workspace do
    name { Bazaar.super_object }
    user_id { 1 }

    factory :workspace_with_user do
      user
    end
  end
end
