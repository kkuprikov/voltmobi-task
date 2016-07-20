# encoding: utf-8
require 'faker'

FactoryGirl.define do
  factory :task do
    name           Faker::Lorem.word
    description    Faker::Lorem.paragraph(2)
    user
    document       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'factory_girl.rb')) }
  end

  factory :task_with_image, class: Task do
    name           Faker::Lorem.word
    description    Faker::Lorem.paragraph(2)
    user
    document       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'linux-penguin-small.png')) }
  end

  factory :task_no_doc, class: Task do
    name           Faker::Lorem.word
    description    Faker::Lorem.paragraph(2)
    user
  end    

end
