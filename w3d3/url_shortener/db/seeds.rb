ActiveRecord::Base.transaction do

  User.create(:email => 'wngo1@gmail.com')
  User.create(:email => 'deager1@gmail.com')
  User.create(:email => 'skycum@gmail.com', :premium => true)

  ShortenedUrl.create(:long_url => 'gmail.com', :short_url => 'g.com', :submitter_id => 1)
  ShortenedUrl.create(:long_url => 'facebook.com', :short_url => 'fb.com', :submitter_id => 2)
  ShortenedUrl.create(:long_url => 'draftkings1.com', :short_url => 'dk1.com', :submitter_id => 2)
  ShortenedUrl.create(:long_url => 'draftkings2.com', :short_url => 'dk2.com', :submitter_id => 3)
  ShortenedUrl.create(:long_url => 'draftkings3.com', :short_url => 'dk3.com', :submitter_id => 3)
  ShortenedUrl.create(:long_url => 'draftkings4.com', :short_url => 'dk4.com', :submitter_id => 3)
  ShortenedUrl.create(:long_url => 'draftkings5.com', :short_url => 'dk5.com', :submitter_id => 3)
  ShortenedUrl.create(:long_url => 'draftkings6.com', :short_url => 'dk6.com', :submitter_id => 3)
  ShortenedUrl.create(:long_url => 'draftkings7.com', :short_url => 'dk7.com', :submitter_id => 3)


  Visit.create(:user_id => 1, :shortened_url_id => 1)
  Visit.create(:user_id => 1, :shortened_url_id => 1)
  Visit.create(:user_id => 2, :shortened_url_id => 1)
  Visit.create(:user_id => 2, :shortened_url_id => 2)

end
