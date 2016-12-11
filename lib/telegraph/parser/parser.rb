require 'nokogiri'

module Telegraph
  module Parser
    class Parser
      attr_accessor :bindings, :page, :article, :image_prefix

      def initialize(binding, image_prefix)
        self.bindings = binding
        self.image_prefix = image_prefix
        parse_html
      end

      private

      def page
        @page ||= Nokogiri::HTML(bindings.content).css('article')
      end

      def images
        {}.tap do |images|
          page.search('.//img').each do |image|
            images.merge!(bindings.image(image.attributes['src'].value,
                                         image_prefix))
          end
        end
      end

      def parse_html
        images_hash = images
        self.article = Article.new(title: tag_content(:h1),
                                   author: tag_content(:address),
                                   content: without_tags,
                                   images: images_hash)
      end

      def tag_content(tag)
        page.search(".//#{tag}").text
      end

      def without_tags
        page_copy = page.dup
        %i(h1 address).each { |tag| page.search(".//#{tag}").remove }

        page_copy.search('.//img').each do |image|
          image.attributes['src'].value =
            bindings.image_id(image.attributes['src'].value, image_prefix)
        end

        page_copy.remove_attr('id').remove_class.to_s
      end
    end
  end
end
