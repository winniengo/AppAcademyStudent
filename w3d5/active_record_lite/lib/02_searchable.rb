require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    cols = params.keys.map { |col| "#{col} = ?"}
    self.parse_all(DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{cols.join(" AND ")}
    SQL
    )
  end
end

class SQLObject
  extend Searchable
end
