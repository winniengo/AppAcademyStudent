require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

# ::all: return an array of all the records in the DB
# ::find: look up a single record by primary key
# #insert: insert a new row into the table to represent the SQLObject.
#update: update the row with the id of this SQLObject
#save: convenience method that either calls insert/update depending on whether or not the SQLObject already exists in the table.

class SQLObject

  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    .first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column_name|
      define_method "#{column_name}" do
        attributes[:"#{column_name}"]
        # instance_variable_get("@attributes[:#{column_name}]")
      end

      define_method "#{column_name}=" do |value|
        attributes[:"#{column_name}"] = value
        # instance_variable_set("@attributes[:#{column_name}]", value)
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    parse_all(DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    )
  end

  def self.parse_all(results)
    results.map do |hash|
      self.new(hash)
    end
  end

  def self.find(id)
    parse_all(DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    ).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name.to_sym)
        self.send(:"#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |col|
      self.send(col)
    end
  end

  def insert
    cols = self.class.columns
    q_marks = ['?'] * cols.count
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{cols.join(", ")})
      VALUES
        (#{q_marks.join(", ")})
    SQL

    self.send(:id=, DBConnection.last_insert_row_id)
  end

  def update
    cols = self.class.columns.drop(1).map { |col| "#{col} = ?" }
    vals = attribute_values.drop(1) + attribute_values.take(1)
    DBConnection.execute(<<-SQL, *vals)
      UPDATE
        #{self.class.table_name}
      SET
        #{cols.join(", ")}
      WHERE
        id = ?
    SQL
  end

  def save
    if self.send(:id)
      update
    else
      insert
    end
  end
end
