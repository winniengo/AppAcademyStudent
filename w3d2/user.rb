require_relative 'model_base'

class User < ModelBase
  attr_accessor :fname, :lname

  def initialize(options)
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def self.get_all
    QuestionsDatabase.instance.execute('SELECT * FROM users').map do |datum|
      User.new(datum)
    end
  end

  def save
    return update if @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, id: @id, fname: fname, lname: lname)
      UPDATE
        users
      SET
        fname = :fname, lname = :lname
      WHERE
        id = :id
      SQL
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
      WHERE
        fname = '#{fname}'
        AND
        lname = '#{lname}'
      SQL
    raise "nothing matches in table" if data.empty?

    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    data = super(id, 'users', self)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end


  def average_karma
    QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT(question_likes.question_id))
        AS karma
      FROM
        question_likes
      WHERE
        question_likes.question_id
        IN (
          SELECT
            q.id
          FROM
            questions q
          WHERE
            q.user_id = #{@id}
          )
      SQL
  end
end
