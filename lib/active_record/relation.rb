module ActiveRecord
  class Relation
    def initialize(klass)
      @klass = klass
      @conditions = []
    end

    def where!(condition)
      @conditions += [condition]
      self
    end

    def where(condition)
      clone.where! condition
    end

    def first
      records.first
    end

    def size
      records.size
    end

    def each(&block)
      records.each(&block)
    end

    def records
      @records ||= @klass.find_by_sql to_sql
    end

    def to_sql
      sql = "SELECT * FROM #{@klass.table_name}"
      sql += " WHERE #{@conditions.join(' AND ')}" if @conditions.any?
      sql
    end
  end
end
