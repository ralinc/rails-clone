module Rails
  class Application
    class << self
      attr_reader :instance

      def inherited(klass)
        super
        @instance = klass.new
      end
    end

    attr_reader :root

    def initialize!
      config_environment = caller.first
      @root = Pathname.new(File.expand_path('../../', config_environment))
      ActiveSupport::Dependencies.autoload_paths = Dir["#{@root}/app/*"]

      ActiveRecord::Base.establish_connection database: "#{@root}/db/#{Rails.env}.sqlite3"
    end
  end
end
