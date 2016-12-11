module Telegraph
  module Parser
    class Article
      attr_accessor :id, :title, :author, :content, :images

      def initialize(attributes)
        attributes.each do |attr, val|
          next unless respond_to?("#{attr}=")
          send("#{attr}=", val)
        end
      end

      def self.load(article_id, image_prefix: '')
        binding = Binding.new(article_id)

        Parser.new(binding, image_prefix).article.tap do |article|
          article.id = article_id
        end
      end
    end
  end
end
