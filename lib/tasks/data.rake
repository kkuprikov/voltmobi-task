namespace :data do
  desc "TODO"
  task generate: :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    users = User.where(role: :user)
    users.each do |user|
      ARGV[1].to_i.times do
        user.tasks << Task.create(name:  Faker::Lorem.word, description: Faker::Lorem.paragraph(2))
      end
    end
  end

end
