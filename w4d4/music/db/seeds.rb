User.create!(email: 'winnie', password: 'winnie')
User.create!(email: 'daniel', password: 'daniel')

Band.create!(name: Faker::Book.publisher)
Band.create!(name: Faker::Book.publisher)

Album.create!(album_name: Faker::Book.title, status: 'STUDIO', band_id: 1)
Album.create!(album_name: Faker::Book.title, status: 'STUDIO', band_id: 1)
Album.create!(album_name: Faker::Book.title, status: 'STUDIO', band_id: 2)
Album.create!(album_name: Faker::Book.title, status: 'LIVE', band_id: 2)

Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 1, lyrics: Faker::Company.bs)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 1)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 2)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 2)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 3)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 3)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: 4)