# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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