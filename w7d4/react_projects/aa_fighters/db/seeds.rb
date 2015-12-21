100.times {
  Fighter.create!(
    name: Faker::Name.name,
    power: Faker::Color.hex_color,
    history: Faker::Lorem.paragraph
  )
}
