require 'singleton'
require 'sqlite3'

class MovieDatabase < SQLite3::Database
  include Singleton

  def initialize
    super(File.dirname(__FILE__) + "/../movie.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    self.instance.execute(*args)
  end
end

# 1. Obtain the cast list for the movie 'Rain Man'; order by the actors'
#    names.
def rain_man_cast
  MovieDatabase.execute(<<-SQL)
    SELECT
      a.name
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    JOIN
      movie m ON m.id = c.movieid
    WHERE
      m.title = 'Rain Man'
    ORDER BY
      a.name
SQL
end

# 2. List the films in which 'Harrison Ford' has appeared; order by
# movie title.
def harrison_ford_films
  MovieDatabase.execute(<<-SQL)
    SELECT
      m.title
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    JOIN
      movie m ON m.id = c.movieid
    WHERE
      a.name = 'Harrison Ford'
    ORDER BY
      m.title
SQL
end

# 3. For each film released in 2000 or later in which 'Christopher
#    Walken' has appeared, list the movie title and the year. Order by
#    movie title.
def christopher_walken_21st_century_films
  MovieDatabase.execute(<<-SQL)
   SELECT
      m.title, m.yr
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    JOIN
      movie m ON m.id = c.movieid
    WHERE
      (a.name = 'Christopher Walken' AND m.yr >= 2000)
    ORDER BY
      m.title
SQL
end

# 4. List the films together with the leading star for all 1962
# films. Order by movie title.
def leading_star_for_1962_films
  MovieDatabase.execute(<<-SQL)
  SELECT
      m.title, a.name
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    JOIN
      movie m ON m.id = c.movieid
    WHERE
      (c.ord = 1 AND m.yr = 1962)
    ORDER BY
      m.title
SQL
end

# 5. There is a film from 2012 in our database for which there is no
# associated casting information. Give the id and title of this movie.
def unknown_actors_2012
  MovieDatabase.execute(<<-SQL)
  SELECT
      m.id, m.title
    FROM
      movie m
    OUTER LEFT JOIN 
      casting c ON c.movieid = m.id
    WHERE
      (m.yr = 2012 AND c.movieid IS NULL)
SQL
end

# 6. Obtain a list in alphabetical order of actors who've had >=26
# starring roles. Order by actor name.
def biggest_stars
  MovieDatabase.execute(<<-SQL)
    SELECT
      a.name, COUNT(*) count
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    WHERE
      c.ord = 1
    GROUP BY
      c.actorid
    HAVING 
      COUNT(*) >= 26
    ORDER BY
      a.name
SQL
end

# 7. List the movie title and the leading actor for all of the films
#    in which 'Ben Affleck' appeared but not as the lead actor.
def stars_working_with_ben_affleck
  MovieDatabase.execute(<<-SQL)
    SELECT
      m.title, a.name
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    JOIN
      movie m ON m.id = c.movieid
    WHERE
      (m.id IN 
        (SELECT
          m2.id
        FROM
          actor a2
        JOIN 
          casting c2 ON c2.actorid = a2.id
        JOIN
          movie m2 ON m2.id = c2.movieid
        WHERE
          (a2.name = 'Ben Affleck' AND c2.ord != 1))
      AND
      c.ord = 1)
SQL
end

# 8. Which were the busiest years for 'John Travolta'? List the year
# and the number of movies he made each year, for any year in which he
# made >2 movies. Order by year.
def busiest_john_travolta_years
  MovieDatabase.execute(<<-SQL)
    SELECT
      m.yr, COUNT(*) count
    FROM
      actor a
    JOIN 
      casting c ON c.actorid = a.id
    JOIN
      movie m ON m.id = c.movieid
    WHERE 
      a.name = 'John Travolta'
    GROUP BY
      m.yr
    HAVING
      COUNT(*) > 2
SQL
end

