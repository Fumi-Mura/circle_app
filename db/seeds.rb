# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  30.times do |i|
    no = i + 1
    user = User.create!(
      name: "user_#{no}",
      email: "email_#{no}@example.com",
      password: "#{no}password#{no}",
      password_confirmation: "#{no}password#{no}"
    )
    user.save!
  end
end

if Rails.env == 'development'
  30.times do |i|
    no = i + 1
    circle = Circle.create!(
      user_id: no,
      name: "user_#{no}",
      content: "content_#{no}",
      image_id: nill
    )
    circle.save!
  end
end


# if Rails.env == 'development'
#   (1..30).each do |i|
#     Blog.create!(user_id: User.find(i+1).id, circle_id: Circle.find(i+1).id,
#     image_id: File.open('./app/assets/images/default_blog_image.jpg'),
#     title: "タイトル#{i}",
#     content: "本文#{i}")
#   end
# end

Category.create([
  { kind: 'スポーツ' },
  { kind: '勉強' },
  { kind: '見る、聞く' },
  { kind: '話す' },
  { kind: '食べる' },
  { kind: '創る' }
])
    
Place.create([
  { place: '北海道' },
  { place: '東京' },
  { place: '愛知' },
  { place: '大阪' },
  { place: '福岡' },
  { place: '沖縄' },
])