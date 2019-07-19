require 'thor'

module Frap
  module Generators
    class Resource
      attr_accessor :name, :attributes, :options

      def initialize(name, options)
        @name = name
        @options = options
      end

      def create_resource
        generate_rails_resource if options['rails']
        generate_flutter_resource if options['flutter']
      end

      private

      def generate_rails_resource


        puts "TODO: rails g resource #{fields}"
      end

      def generate_flutter_resource
        puts "TODO: frap g flutter resource #{fields}"
      end

      def fields
        @fields ||= build_fields
      end

      def build_fields
        fields_string = ''
        options[:attributes].each { |k, v| fields_string << "#{k}:#{v} " }

        return fields_string
      end
    end
  end
end