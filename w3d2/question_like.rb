class QuestionLike
  def initialize(options)
    @id, @user_id, @question_id = options.values_at('id', 'user_id', 'question_id')
  end

  def self.get_all
    QuestionsDatabase.instance.execute('SELECT * FROM question_likes').map do |datum|
      QuestionLike.new(datum)
    end
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = #{id}
      SQL
    raise "nothing matches in table" if data.empty?

    QuestionLike.new(data.first)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        u.id, u.fname, u.lname
      FROM
        users u
      JOIN
        question_likes ON question_likes.user_id = u.id
      WHERE
        question_likes.question_id = #{question_id}
      SQL

    raise "no likers for question" if data.empty?

    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        COUNT(*) AS likes
      FROM
        question_likes
      GROUP BY
        question_id
      HAVING
        question_id = #{question_id}
      SQL
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions q
      JOIN
        question_likes ON question_likes.question_id = q.id
      WHERE
        question_likes.user_id = #{user_id}
    SQL

    raise "No liked questions for user" if data.empty?

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions q
      JOIN
        question_likes ON question_likes.question_id = q.id
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(*) DESC
      SQL

    raise 'n > number of questions' if n > data.count
    data.take(n).map { |datum| Question.new(datum) }
  end
end
