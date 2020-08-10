# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
Category.create!([
    { kind: '身体を動かす' },
    { kind: '勉強する' },
    { kind: 'イベントに行く' },
    { kind: '旅をする' },
    { kind: '見たい・聞きたい' },
    { kind: 'テーマで話す' },
    { kind: 'これが食べたい' },
    { kind: '新しく創る' }
  ])

if Rails.env == 'development'
  30.times do |i|
    no = i + 1
    user = User.create!(
      name: "user_#{no}",
      email: "email_#{no}@example.com",
      password: "password#{no}",
      password_confirmation: "password#{no}"
    )
    user.save!
  end

users = User.all
user  = users.first
following = users[2..30]
followers = users[3..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

end
