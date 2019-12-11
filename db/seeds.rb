Agent.create!(name:  "agent",
             email: "agent@Koto.jp",
             category: "旅行会社",
             address: "京都府京都市",
             scale: "従業員100~150名",
             target_audience: "中間層",
             password:              "1234abcd",
             password_confirmation: "1234abcd",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

50.times do |n|
  name = Faker::Name.name
  email = "agent#{n + 1}@Koto.jp"
  category = "旅行会社",
  address = "京都府京都市",
  scale = "従業員100~150名",
  target_audience = "中間層",
  password = "1234abcd"
  Agent.create!(name: name,
         email: email,
         category: category,
         address: address,
         scale: scale,
         target_audience: target_audience,
         password: password,
         password_confirmation: password,
         activated: true,
         activated_at: Time.zone.now)
end

Owner.create!(name:  "owner",
             email: "owner@Koto.jp",
             password:              "1234abcd",
             password_confirmation: "1234abcd",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

50.times do |n|
  name = Faker::Name.name
  email = "owner#{n + 1}@Koto.jp"
  password = "1234abcd"
  Owner.create!(name: name,
         email: email,
         password: password,
         password_confirmation: password,
         activated: true,
         activated_at: Time.zone.now)
end

%W[アメリカ 欧州 オーストラリア 中国 台湾 韓国 東南アジア 南アメリカ 中東 アフリカ その他].each { |a| Target.create(name: a) }
