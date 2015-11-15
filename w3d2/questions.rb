require 'sqlite3'
require 'singleton'
require_relative 'user'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'


class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end

# class User
#
#   def initialize(options)
#     @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
#   end
#
#   def self.get_all
#     QuestionsDatabase.instance.execute('SELECT * FROM users').map do |datum|
#       User.new(datum)
#     end
#   end
#
#   def self.find_by_name(fname, lname)
#     data = QuestionsDatabase.instance.execute(<<-SQL)
#       SELECT
#         *
#       FROM
#         users
#       WHERE
#         fname = '#{fname}'
#         AND
#         lname = '#{lname}'
#       SQL
#     raise "nothing matches in table" if data.empty?
#
#     User.new(data.first)
#   end
# end
#
# class Question
#
#   def initialize(options)
#     @id, @title, @body, @user_id = options.values_at('id', 'title', 'body', 'user_id')
#   end
#
#   def self.get_all
#     QuestionsDatabase.instance.execute('SELECT * FROM questions').map do |datum|
#       Question.new(datum)
#     end
#   end
#
#   def self.find_by_id(id)
#     data = QuestionsDatabase.instance.execute(<<-SQL)
#       SELECT
#         *
#       FROM
#         questions
#       WHERE
#         id = #{id}
#       SQL
#     raise "nothing matches in table" if data.empty?
#
#     Question.new(data.first)
#   end
# end
#
# class QuestionFollows
#
#   def initialize(options)
#     @id, @user_id, @question_id = options.values_at('id', 'user_id', 'question_id')
#   end
#
#   def self.get_all
#     QuestionsDatabase.instance.execute('SELECT * FROM question_follows').map do |datum|
#       QuestionFollows.new(datum)
#     end
#   end
#
#   def self.find_by_id(id)
#     data = QuestionsDatabase.instance.execute(<<-SQL)
#       SELECT
#         *
#       FROM
#         question_follows
#       WHERE
#         id = #{id}
#       SQL
#     raise "nothing matches in table" if data.empty?
#
#     QuestionFollows.new(data.first)
#   end
# end
#
# class Replies
#
#   def initialize(options)
#     @id, @subject_question_id, @parent_reply_id, @user_id, @body =
#       options.values_at('id', 'subject_question_id', 'parent_reply_id', 'user_id', 'body')
#   end
#
#   def self.get_all
#     QuestionsDatabase.instance.execute('SELECT * FROM replies').map do |datum|
#       Replies.new(datum)
#     end
#   end
#
#   def self.find_by_id(id)
#     data = QuestionsDatabase.instance.execute(<<-SQL)
#       SELECT
#         *
#       FROM
#         replies
#       WHERE
#         id = #{id}
#       SQL
#     raise "nothing matches in table" if data.empty?
#
#     Replies.new(data.first)
#   end
# end
