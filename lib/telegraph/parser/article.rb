module Telegraph
  module Parser
    class Article
      ATTRIBUTES = %i[id title author content images].freeze

      attr_reader *ATTRIBUTES

      def initialize(attributes)
        attributes.each do |attr, val|
          next unless ATTRIBUTES.include?(attr.to_sym)
          instance_variable_set(:"@#{attr}", val)
        end
      end

      def self.find(article_id, image_prefix: '')
        parser = Parser.new(article_id, image_prefix)
        parser.fetch_and_parse!
        Article.new(parser.parsed_data)
      end
    end
  end
end
