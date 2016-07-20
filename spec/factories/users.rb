# encoding: utf-8
FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password               '111111'
    role                   'user'
  end

  factory :admin, class: User do
    email                  'admin@admin.com'
    password               'topsecret'
    role                   'admin'
  end
end
