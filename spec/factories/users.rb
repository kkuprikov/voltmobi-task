# encoding: utf-8
FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password '111111'
    role 'user'
  end
end
