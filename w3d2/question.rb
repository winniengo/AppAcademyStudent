require_relative 'model_base'

class Question < ModelBase

  attr_accessor :title, :body

  def initialize(options)
    @id, @title, @body, @user_id = options.values_at('id', 'title', 'body', 'user_id')
  end

  def self.get_all
    QuestionsDatabase.instance.execute('SELECT * FROM questions').map do |datum|
      Question.new(datum)
    end
  end

  def self.find_by_id(id)
    super(id, 'questions', self)
  end

  def save
    return update if @id

    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions(title, body, user_id)
      VALUES
        (?, ?, ?)
      SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, id: @id, title: title, body: body)
      UPDATE
        questions
      SET
        title = :title, body = :body
      WHERE
        id = :id
      SQL
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = #{author_id}
      SQL
    raise "nothing matches in table" if data.empty?

    data.map { |datum| Question.new(datum) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end
