User.create!(email: 'winnie', password: 'winnie')
User.create!(email: 'daniel', password: 'daniel')

band1 = Band.create!(name: Faker::Book.publisher)
band2 = Band.create!(name: Faker::Book.publisher)

album1 = Album.create!(album_name: Faker::Book.title, status: 'STUDIO', band_id: band1.id)
album2 = Album.create!(album_name: Faker::Book.title, status: 'STUDIO', band_id: band1.id)
album3 = Album.create!(album_name: Faker::Book.title, status: 'STUDIO', band_id: band2.id)
album4 = Album.create!(album_name: Faker::Book.title, status: 'LIVE', band_id: band2.id)

Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album1.id, lyrics: Faker::Company.bs)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album1.id)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album2.id)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album2.id)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album3.id)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album3.id)
Track.create!(track_name: Faker::Book.title, status: 'REGULAR', album_id: album4.id)