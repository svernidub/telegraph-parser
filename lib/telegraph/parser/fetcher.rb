require 'open-uri'

module Telegraph
  module Parser
    class Fetcher
      HOST = 'telegra.ph'.freeze

      def fetch(article_id)
        Net::HTTP.get(HOST, "/#{article_id}")
      rescue EOFError
        raise Telegraph::Parser::ArticleNotFound
      end

      def fetch_image(src, prefix)
        { image_id(src, prefix) => open(src).read }
      end

      def image_id(src, prefix)
        "#{prefix}/#{File.basename(URI.parse(src).path)}"
      end
    end
  end
end
