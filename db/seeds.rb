# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!(username: "team", email: "team@example.com", password: "123456")
users = []
puts "Creating users"
50.times do
  user = User.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "111111")
  users << user
  print "+"
end
puts
puts "Creating Content"

30.times do
  print '.'
  q = Question.create!(title: Faker::Lorem.sentence.sub(/\./, "?"), content: Faker::Lorem.paragraph, user: users.sample)
  Random.rand(3).times do
    com = Comment.create!(content: Faker::Lorem.sentence, user: users.sample, commentable: q)
  end
  Random.rand(4).times do
    print "+"
    ans = Answer.create!(content: Faker::Lorem.sentence, user: users.sample, question: q)
    Random.rand(3).times do
      com = Comment.create!(content: Faker::Lorem.sentence, user: users.sample, commentable: ans)
    end
  end
  puts
end


questions = Question.all
users = User.all
answers = Answer.all
comments = Comment.all

