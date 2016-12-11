require 'open-uri'

module Telegraph
  module Parser
    class Binding
      BASE_URI = 'telegra.ph'

      attr_accessor :article_id

      def initialize(article_id)
        self.article_id = article_id
      end

      def content
        Net::HTTP.get(BASE_URI, "/#{article_id}")
      rescue EOFError
        ""
      end

      def image(src, prefix)
        src.gsub!('http://telegra.ph', '')
        { image_id(src, prefix) => open("http://#{BASE_URI}#{src}").read }
      end

      def image_id(src, prefix)
        src.gsub!('http://telegra.ph', '')
        "#{prefix}/#{File.basename(URI.parse("#{BASE_URI}#{src}").path)}"
      end
    end
  end
end
