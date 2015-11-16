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

# List the films in which 'Chuck Norris' has appeared; order by movie
# title.
def bearded_films
  MovieDatabase.execute(<<-SQL)
    SELECT
      movie.title
    FROM 
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Chuck Norris'
  SQL
end

# Obtain the cast list for the movie "Zombies of the Stratosphere";
# order by the actor's name.
def zombie_cast
  MovieDatabase.execute(<<-SQL)
    SELECT
      actor.name
    FROM
      actor
    JOIN
      casting ON casting.actorid = actor.id
    JOIN
      movie ON casting.movieid = movie.id
    WHERE
      movie.title = 'Zombies of the Stratosphere'
    ORDER BY
      actor.name
  SQL
end

# Which were the busiest years for 'Danny DeVito'? Show the year and
# the number of movies he acted in for any year in which he was part of
# >2 movies. Order by year. Note the 'V' is capitalized.
def biggest_years_for_little_danny
  MovieDatabase.execute(<<-SQL)
    SELECT
      movie.yr, 
      COUNT(movie.title) count
    FROM
      movie
    WHERE
      movie.id IN (
        SELECT 
          m2.id
        FROM 
          movie m2
        JOIN
          casting ON casting.movieid = m2.id
        JOIN
          actor ON casting.actorid = actor.id
        WHERE
          actor.name = 'Danny DeVito'
        )
    GROUP BY
      movie.yr
    HAVING
      COUNT(movie.title) > 2
  SQL
end

# List the films where 'Nicolas Cage' has appeared, but not in the
# star role. Order by movie title.
def more_cage_please
  MovieDatabase.execute(<<-SQL)
    SELECT
      movie.title
    FROM 
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      (actor.name = 'Nicolas Cage' AND casting.ord != 1)
    ORDER BY
      movie.title
  SQL
end

# List the films together with the leading star for all 1908
# films. Order by movie title.
def who_is_florence_lawrence
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, actor.name
  FROM
    movie
  JOIN
    casting ON casting.movieid = movie.id
  JOIN
    actor ON casting.actorid = actor.id
  WHERE
    (movie.yr = 1908 AND casting.ord = 1)
  ORDER BY
    movie.title

  SQL
end

# Some actors listed in our database are not associated with any actual
# movie role(s). How many such actors are there? Alias this number as
# 'num_bad_actors'.
def count_bad_actors
  MovieDatabase.execute(<<-SQL)
  SELECT
    COUNT(*) num_bad_actors
  FROM
    actor
  LEFT OUTER JOIN
    casting ON actor.id = casting.actorid
  WHERE
    casting.movieid IS NULL

SQL
end

# Obtain a list in alphabetical order of actors who've had exactly 20
# starring roles. Order by actor name.
def twenty_roles
  MovieDatabase.execute(<<-SQL)
    SELECT
      actor.name
    FROM
      actor
    JOIN
      casting ON casting.actorid = actor.id
    WHERE
      casting.ord = 1
    GROUP BY
      casting.actorid
    HAVING 
      COUNT(DISTINCT casting.movieid) = 20
    ORDER BY
      actor.name

  SQL
end

# List the film title and the leading actor for all of the films
# 'Chris Farley' played in.
def chris_is_missed
  MovieDatabase.execute(<<-SQL)
    SELECT
      movie.title, actor.name
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      movie.id IN (
        SELECT
          c2.movieid
        FROM
          casting c2
        JOIN
          actor a2 ON c2.actorid = a2.id
        WHERE
          a2.name = 'Chris Farley'
        )
      AND
      casting.ord = 1


  SQL
end
