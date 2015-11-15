class QuestionFollow

  def initialize(options)
    @id, @user_id, @question_id = options.values_at('id', 'user_id', 'question_id')
  end

  def self.get_all
    QuestionsDatabase.instance.execute('SELECT * FROM question_follows').map do |datum|
      QuestionFollow.new(datum)
    end
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = #{id}
      SQL
    raise "nothing matches in table" if data.empty?

    QuestionFollow.new(data.first)
  end

  def self.followers_for_question(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        u.id, u.fname, u.lname
      FROM
        users u
      JOIN
        question_follows ON u.id = question_follows.user_id
      WHERE
        question_id = #{question_id}
      SQL

    raise "nothing matches in table" if data.empty?
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions q
      JOIN
        question_follows ON q.id = question_follows.question_id
      WHERE
        question_follows.user_id = #{user_id}
      SQL

    raise "nothing matches in table" if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions q
      JOIN
        question_follows ON question_follows.question_id = q.id
      GROUP BY
        question_follows.question_id
      ORDER BY
        COUNT(*) DESC
      SQL

    raise 'n > number of questions' if n > data.count
    data.take(n).map { |datum| Question.new(datum) }
  end
end
