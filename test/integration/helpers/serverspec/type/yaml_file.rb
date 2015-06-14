require 'yaml'

module Serverspec
  module Type
    class YAMLFile < Base
      def initialize(path)
        super(path)
        @yaml = YAML.load_file(path)
      end

      def has_node?(path, value = nil)
        case path
        when Array
          node = path.inject(@yaml) { |node, key| node.respond_to?(:keys) ? node[key] : nil }
          value.nil? ? !node.nil? : node == value
        when String
          has_node?([path], value)
        else
          raise TypeError.new("Expecting type to be an Array or String, got #{path.class}")
        end
      end
    end

    def yaml_file(path)
      YAMLFile.new(path)
    end
  end
end

include Serverspec::Type
