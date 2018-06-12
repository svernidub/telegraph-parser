require 'spec_helper'

describe Telegraph::Parser::Fetcher do
  describe '#fetch' do
    it 'performs HTTP request to telegra.ph' do
      allow(Net::HTTP).to receive(:get).and_return 'content!'

      expect(Net::HTTP).to receive(:get).with('http://telegra.ph', '/my-article')

      expect(subject.fetch('my-article')).to eq 'content!'
    end

    it 'raises ArticleNotFound if article does not exists' do
      allow(Net::HTTP).to receive(:get).and_raise EOFError

      expect { subject.fetch('my-article') }
        .to raise_error Telegraph::Parser::ArticleNotFound
    end
  end
end