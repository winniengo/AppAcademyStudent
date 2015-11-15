require_relative 'model_base'


class Reply < ModelBase
   attr_accessor :body

  def initialize(options)
    @id, @subject_question_id, @parent_reply_id, @user_id, @body =
      options.values_at('id', 'subject_question_id', 'parent_reply_id', 'user_id', 'body')
  end

  def self.get_all
    QuestionsDatabase.instance.execute('SELECT * FROM replies').map do |datum|
      Reply.new(datum)
    end
  end

  def self.find_by_id(id)
    super(id, 'replies', self)
  end

  def save
    return update if @id
    QuestionsDatabase.instance.execute(<<-SQL, @subject_question_id, @parent_reply_id, @user_id, @body)
      INSERT INTO
        replies(subject_question_id, parent_reply_id, user_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, id: @id, body: @body)
      UPDATE
        replies
      SET
         body = :body
      WHERE
        id = :id
      SQL
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = #{user_id}
      SQL
    raise "nothing matches in table" if data.empty?

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question_id = #{question_id}
      SQL
    raise "nothing matches in table" if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@subject_question_id)
  end

  def parent_reply
    raise "this is the top reply" if @parent_reply_id.nil?
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = #{@id}
      SQL

    raise "no subreplies" if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

end
