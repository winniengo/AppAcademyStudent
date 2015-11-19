require 'rspec'
require 'movie_sql'

describe "#rain_man_cast" do
  it "1. List 'Rain Man' cast by name" do
    expect(rain_man_cast).to eq([
      {"name"=>"Barry Levinson"},
      {"name"=>"Bonnie Hunt"},
      {"name"=>"Dustin Hoffman"},
      {"name"=>"Jack Murdock"},
      {"name"=>"Jerry Molen"},
      {"name"=>"Lucinda Jenney"},
      {"name"=>"Michael D. Roberts"},
      {"name"=>"Tom Cruise"},
      {"name"=>"Valeria Golino"}
    ])
  end
end

describe "#harrison_ford_films" do
  it "2. List Harrison Ford films by movie title" do
    expect(harrison_ford_films).to eq([
      { "title" => "A Hundred and One Nights" },
      { "title" => "American Graffiti" },
      { "title" => "Apocalypse Now" },
      { "title" => "Dead Heat on a Merry-Go-Round" },
      { "title" => "Extraordinary Measures" },
      { "title" => "Firewall" },
      { "title" => "Force 10 From Navarone" },
      { "title" => "Hawthorne of the U.S.A." },
      { "title" => "Hollywood Homicide" },
      { "title" => "Indiana Jones and the Last Crusade" },
      { "title" => "Jimmy Hollywood" },
      { "title" => "More American Graffiti" },
      { "title" => "Morning Glory" },
      { "title" => "Presumed Innocent" },
      { "title" => "Regarding Henry" },
      { "title" => "Sabrina" },
      { "title" => "Sally of the Sawdust" },
      { "title" => "Shadows" },
      { "title" => "Six Days Seven Nights" },
      { "title" => "Smilin' Through" },
      { "title" => "Star Wars Episode IV: A New Hope" },
      { "title" => "Star Wars Episode V: The Empire Strikes Back" },
      { "title" => "Star Wars Episode VI: Return of the Jedi" },
      { "title" => "The Conversation" },
      { "title" => "The Devil's Own" },
      { "title" => "The Fugitive" },
      { "title" => "The Star Wars Holiday Special" },
      { "title" => "What Lies Beneath" },
      { "title" => "Witness" }
    ])
  end
end

describe "#christopher_walken_21st_century_films" do
  it "3. List Christopher Walken 21st century films by movie title" do
    expect(christopher_walken_21st_century_films).to eq([
      {"title"=>"Balls of Fury", "yr"=>2007},
      {"title"=>"Catch Me If You Can", "yr"=>2002},
      {"title"=>"Click", "yr"=>2006},
      {"title"=>"Envy", "yr"=>2004},
      {"title"=>"Gigli", "yr"=>2003},
      {"title"=>"Joe Dirt", "yr"=>2001},
      {"title"=>"Man On Fire", "yr"=>2004},
      {"title"=>"Man of the Year", "yr"=>2006},
      {"title"=>"The Country Bears", "yr"=>2002},
      {"title"=>"The Rundown", "yr"=>2003},
      {"title"=>"The Stepford Wives", "yr"=>2004},
      {"title"=>"Wedding Crashers", "yr"=>2005}
    ])
  end
end

describe "#leading_star_for_1962_films" do
  it "4. List 1962 leading stars by movie title" do
    expect(leading_star_for_1962_films).to eq([
      { "title" => "A Kind of Loving", "name" => "Alan Bates" },
      { "title" => "Barabbas", "name" => "Anthony Quinn" },
      { "title" => "Big and Little Wong Tin Bar", "name" => "Jackie Chan" },
      { "title" => "Billy Rose's Jumbo", "name" => "Doris Day" },
      { "title" => "Boys' Night Out", "name" => "Kim Novak" },
      { "title" => "Cape Fear", "name" => "Gregory Peck" },
      { "title" => "Carry On Cruising", "name" => "Sid James" },
      { "title" => "Days of Wine and Roses", "name" => "Jack Lemmon" },
      { "title" => "Gay Purr-ee", "name" => "Judy Garland" },
      { "title" => "Gypsy", "name" => "Rosalind Russell" },
      { "title" => "In Search of the Castaways", "name" => "Hayley Mills" },
      { "title" => "Jigsaw", "name" => "Jack Warner" },
      { "title" => "L'Eclisse", "name" => "Alain Delon" },
      { "title" => "La notte", "name" => "Marcello Mastroianni" },
      { "title" => "Life for Ruth", "name" => "Michael Craig" },
      { "title" => "Lolita", "name" => "James Mason" },
      { "title" => "Long Day's Journey into Night", "name" => "Katharine Hepburn" },
      { "title" => "Love at Twenty", "name" => "Jean-Pierre Léaud" },
      { "title" => "Lycanthropus", "name" => "Barbara Lass" },
      { "title" => "Mother Joan of the Angels", "name" => "Lucyna Winnicka" },
      { "title" => "Mutiny on the Bounty", "name" => "Marlon Brando" },
      { "title" => "Panic in Year Zero!", "name" => "Ray Milland" },
      { "title" => "Period of Adjustment", "name" => "Anthony Franciosa" },
      { "title" => "Pressure Point", "name" => "Bobby Darin" },
      { "title" => "Ride the High Country", "name" => "Randolph Scott" },
      { "title" => "State Fair", "name" => "Pat Boone" },
      { "title" => "Sundays and Cybele", "name" => "Hardy Krüger" },
      { "title" => "Term of Trial", "name" => "Laurence Olivier" },
      { "title" => "That Touch of Mink", "name" => "Cary Grant" },
      { "title" => "The 300 Spartans", "name" => "King Leonidas" },
      { "title" => "The Apartment", "name" => "Jack Lemmon" },
      { "title" => "The Counterfeit Traitor", "name" => "William Holden" },
      { "title" => "The Manchurian Candidate", "name" => "Frank Sinatra" },
      { "title" => "The Music Man", "name" => "Robert Preston" },
      { "title" => "The Phantom of the Opera", "name" => "Herbert Lom" },
      { "title" => "The Trial", "name" => "Anthony Perkins" },
      { "title" => "Through a Glass Darkly", "name" => "Harriet Andersson" },
      { "title" => "To Kill a Mockingbird", "name" => "Mary Badham" },
      { "title"=>"Village of Daughters", "name"=>"Yvonne Romain"},
      { "title" => "What Ever Happened to Baby Jane?", "name" => "Joan Crawford" },
      { "title" => "Who's Got the Action?", "name" => "Dean Martin" }
    ])
  end
end

describe "#unknown_actors_2012" do
  it "5. Give the 2012 movie without casting info" do
    expect(unknown_actors_2012).to eq([
      {"id"=>20377, "title"=>"Titanic"}
    ])
  end
end

describe "#biggest_stars" do
  it "6. List actors with >= 26 starring roles (by name)" do
    expect(biggest_stars).to eq([
      {"name"=>"Clint Eastwood", "count"=>26},
      {"name"=>"Robert De Niro", "count"=>26}
    ])
  end
end

describe "#stars_working_with_ben_affleck" do
  it "7. List movies and stars supported by Ben Affleck, by movie title" do
    expect(stars_working_with_ben_affleck).to eq([
      {"title"=>"Armageddon", "name"=>"Bruce Willis"},
      {"title"=>"Boiler Room", "name"=>"Giovanni Ribisi"},
      {"title"=>"Buffy the Vampire Slayer", "name"=>"Kristy Swanson"},
      {"title"=>"Dazed and Confused", "name"=>"Jason London"},
      {"title"=>"Glory Road", "name"=>"Josh Lucas"},
      {"title"=>"Good Will Hunting", "name"=>"Matt Damon"},
      {"title"=>"Hollywoodland", "name"=>"Adrien Brody"}
    ])
  end
end

describe "#busiest_john_travolta_years" do
  it "8. List years in which John Travolta made >2 films" do
    expect(busiest_john_travolta_years).to eq([
      { "yr" => 1998, "count" => 3 }
    ])
  end
end

