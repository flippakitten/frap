require 'thor'

module Frap
  module Commands
    class Generate < Thor
      desc 'resource NAME', 'generate a resource'
      method_option :rails, type: :boolean, aliases: :r, default: true
      method_option :flutter, type: :boolean, aliases: :f, default: true
      method_option :attributes, type: :hash, aliases: :a

      def resource(name)
        Frap::CreateResource.new(name, options).create_resource
      end
    end
  end
end