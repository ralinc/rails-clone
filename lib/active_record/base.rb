require 'active_record/connection_adapter'

module ActiveRecord
  class Base
    def initialize(attributes = {})
      @attributes = attributes
    end

    def method_missing(name)
      return @attributes[name] if self.class.column?(name)
      super
    end

    def respond_to_missing?(name, include_all = false)
      return true if self.class.column?(name)
      super
    end

    class << self
      def abstract_class=(_value)
      end

      def all
        connection.execute("SELECT * FROM #{table_name}").map do |attributes|
          new attributes
        end
      end

      def find(id)
        attributes = connection.execute("SELECT * FROM #{table_name} WHERE id = #{id.to_i}").first
        new attributes
      end

      def column?(name)
        columns.include?(name)
      end

      def columns
        connection.columns table_name
      end

      def table_name
        name.downcase + 's'
      end

      def connection
        @@connection
      end

      def establish_connection(options)
        @@connection = ConnectionAdapter::SqliteAdapter.new options[:database]
      end
    end
  end
end
