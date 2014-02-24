FactoryGirl.define do
  factory :user do
    username "test"
    email { "#{username}@example.com".downcase }
    password {username}
  end

  factory :admin, class: User do
    username "admin"
    email { "#{username}@example.com".downcase }
    password {username}
    is_superuser true
  end
end