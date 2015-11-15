class ModelBase
  # def self.find_by_id(id, table)
  #   QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       #{table}
  #     WHERE
  #       id = #{id}
  #     SQL
  #   raise "nothing matches in table" if data.empty?
  # end

  def self.find_by_id(id, table, object)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table}
      WHERE
        id = #{id}
      SQL
    raise "nothing matches in table" if data.empty?

    data.map { |datum| object.new(datum) }
  end

  def self.get_all(table, object)
    QuestionsDatabase.instance.execute('SELECT * FROM #{table}').map do |datum|
      object.new(datum)
    end
  end
end
