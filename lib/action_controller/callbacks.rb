module ActionController
  module Callbacks
    class Callback
      def initialize(method, options)
        @method = method
        @options = options
      end

      def match?(action)
        if @options[:only]
          @options[:only].include? action.to_sym
        else
          true
        end
      end

      def call(controller)
        controller.send @method
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def before_action(method, options = {})
        before_actions << Callback.new(method, options)
      end

      def before_actions
        @before_actions ||= []
      end
    end

    def process(action)
      self.class.before_actions.each do |callback|
        callback.call self if callback.match? action
      end

      super
    end
  end
end
