FactoryBot.define do
  factory :user do
    email { "joe_doe@mail.com" }
    password { "password1" }
    username { email.split("@").first }
  end
end
