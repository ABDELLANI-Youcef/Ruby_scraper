require 'nokogiri'
require 'open-uri'
require_relative '../lib/scraper'

describe Scraper do
  let(:scraper) { Scraper.new }
  describe '#initialize' do
    it 'should return the developer attribute after initialization and it should be false' do
      expect(scraper.developer).to eql(false)
    end
    it 'should return the developer attribute after modification and it should be true' do
      scraper.developer = true
      expect(scraper.developer).to eql(true)
    end
    it 'should return the request_uri attribute after initialization and it should be empty string' do
      expect(scraper.request_uri).to eql('')
    end
    it 'should return the request_uri attribute after modification and it should be a new string' do
      scraper.request_uri = 'https://github.com/trending'
      expect(scraper.request_uri).to eql('https://github.com/trending')
    end
    it 'should return the attribute informations after initialization and it should be an empty array' do
      expect(scraper.informations).to eql([])
    end
    it 'should return the attribute informations after scraping a git hub page and it should not be an empty array' do
      scraper.request_uri = 'https://github.com/trending'
      scraper.scrap_page
      expect(scraper.informations).not_to eql([])
    end

    it 'When the programming language is specified, all the trends should be as the specified' do
      scraper.request_uri = 'https://github.com/trending/css?since=daily'
      scraper.scrap_page
      trends_number = scraper.informations.size
      prog_number = 0
      scraper.informations.each do |info|
        prog_number += 1 if info[:programming_language] == 'CSS'
      end
      expect(prog_number).to eql(trends_number)
    end
  end
end
