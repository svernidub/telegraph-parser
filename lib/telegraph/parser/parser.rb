require 'nokogiri'

module Telegraph
  module Parser
    class Parser
      attr_reader :parsed_data

      def initialize(article_id, image_prefix)
        @fetcher = Fetcher.new
        @article_id = article_id
        @image_prefix = image_prefix
      end

      def fetch_and_parse!
        load_page!
        load_images!
        compile_parsed_data!
      end

      private

      def load_page!
        @page = Nokogiri::HTML(@fetcher.fetch(@article_id)).css('article')
      end

      def compile_parsed_data!
        @parsed_data = {
          article_id: @article_id,
          title:      tag_content(:h1),
          author:     tag_content(:address),
          content:    without_tags,
          images:     @images
        }
      end

      def load_images!
        @images = {}

        @page.search('.//img').each do |image|
          i = @fetcher.fetch_image(image.attributes['src'].value, @image_prefix)
          @images.merge!(i)
        end
      end

      def tag_content(tag)
        @page.search(".//#{tag}").text
      end

      def without_tags
        page_copy = @page.dup
        %i(h1 address).each { |tag| @page.search(".//#{tag}").remove }

        page_copy.search('.//img').each do |image|
          image.attributes['src'].value =
            @fetcher.image_id(image.attributes['src'].value, @image_prefix)
        end

        page_copy.remove_attr('id').remove_class.to_s
      end
    end
  end
end
