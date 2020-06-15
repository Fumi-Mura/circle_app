# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

Category.create!([
    { kind: 'スポーツ' },
    { kind: '勉強' },
    { kind: 'イベント' },
    { kind: '旅' },
    { kind: '見る、聞く' },
    { kind: '話す' },
    { kind: '食べる' },
    { kind: '創る' }
  ])

Category.create!([
    { place: '北海道' },
    { place: '青森県' },
    { place: '岩手県' },
    { place: '宮城県' },
    { place: '秋田県' },
    { place: '山形県' },
    { place: '福島県' },
    { place: '茨城県' },
    { place: '栃木県' },
    { place: '群馬県' },
    { place: '埼玉県' },
    { place: '千葉県' },
    { place: '東京都' },
    { place: '神奈川県' },
    { place: '山梨県' },
    { place: '長野県' },
    { place: '新潟県' },
    { place: '富山県' },
    { place: '石川県' },
    { place: '福井県' },
    { place: '岐阜県' },
    { place: '静岡県' },
    { place: '愛知県' },
    { place: '三重県' },
    { place: '滋賀県' },
    { place: '京都府' },
    { place: '大阪府' },
    { place: '兵庫県' },
    { place: '奈良県' },
    { place: '和歌山県' },
    { place: '鳥取県' },
    { place: '島根県' },
    { place: '岡山県' },
    { place: '広島県' },
    { place: '山口県' },
    { place: '徳島県' },
    { place: '香川県' },
    { place: '愛媛県' },
    { place: '高知県' },
    { place: '福岡県' },
    { place: '佐賀県' },
    { place: '長崎県' },
    { place: '熊本県' },
    { place: '大分県' },
    { place: '宮崎県' },
    { place: '鹿児島県' },
    { place: '沖縄県' },
    { place: 'その他'}
  ])
    
  
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

#   30.times do |i|
#     no = i + 1
#     circle = Circle.create!(
#       user_id: no,
#       name: "user_#{no}",
#       content: "content_#{no}",
#       image_id: nill
#     )
#     circle.save!
#   end

end

