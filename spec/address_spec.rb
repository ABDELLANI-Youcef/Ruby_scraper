require_relative '../lib/address'

describe AddressUri do
  let(:address) { AddressUri.new }
  describe '#initialize' do
    it 'Should return developer attribute after initialization and it should be false' do
      expect(address.developer).to eql(false)
    end

    it 'Should return developer attribute and it should be true' do
      address.developer = true
      expect(address.developer).to eql(true)
    end

    it 'Should return language attribute after initialization and it should be empty string' do
      expect(address.language).to eql('')
    end

    it "Should return language attribute after modification and it should be equal to 'css'" do
      address.language = 'css'
      expect(address.language).to eql('css')
    end

    it 'Should return date attribute after initialization and it should be empty string' do
      expect(address.date).to eql('')
    end

    it "Should return date attribute after modification and it should be 'week'" do
      address.date = 'week'
      expect(address.date).to eql('week')
    end
  end

  describe 'generate_address' do
    it 'should return the request URI address when developer attribute is false, language and date are empty string' do
      expect(address.generate_address).to eql('https://github.com/trending')
    end

    it 'should return the request URI address when developer attribute is true, language and date are empty string' do
      address.developer = true
      expect(address.generate_address).to eql('https://github.com/trending/developers')
    end

    it "Should return the request URI when the language is set to 'css' and the date is not" do
      address.language = 'css'
      expect(address.generate_address).to eql('https://github.com/trending/css?since=daily')
    end

    it "Should return the request URI when the language is set to 'html' and the date is not" do
      address.language = 'html'
      expect(address.generate_address).to eql('https://github.com/trending/html?since=daily')
    end

    it "Should return the request URI in developer trending page when the language is set to 'css' & the date isn't" do
      address.developer = true
      address.language = 'css'
      expect(address.generate_address).to eql('https://github.com/trending/developers/css?since=daily')
    end

    it "Should return the URI in developer trending page if the language is set to 'html' and the date is not" do
      address.developer = true
      address.language = 'html'
      expect(address.generate_address).to eql('https://github.com/trending/developers/html?since=daily')
    end

    it "Return request URI for repositories trending when the language is specified and the date is set to 'week'" do
      address.language = 'c'
      address.date = 'week'
      expect(address.generate_address).to eql('https://github.com/trending/c?since=weekly')
    end

    it "Return request URI for repositories trending when the language is specified and the date is set to 'month'" do
      address.language = 'c'
      address.date = 'month'
      expect(address.generate_address).to eql('https://github.com/trending/c?since=monthly')
    end

    it "Return request URI for repositories trending when the language is not specified and the date is set 'week'" do
      address.date = 'week'
      expect(address.generate_address).to eql('https://github.com/trending?since=weekly')
    end

    it "Return request URI of repositories trending when the language isn't specified and the date is set 'month'" do
      address.date = 'month'
      expect(address.generate_address).to eql('https://github.com/trending?since=monthly')
    end

    it "Return request URI for developer trending when the language is specified and the date is set to 'week'" do
      address.developer = true
      address.language = 'c'
      address.date = 'week'
      expect(address.generate_address).to eql('https://github.com/trending/developers/c?since=weekly')
    end

    it "Return request URI for developer trending when the language is specified and the date is set to 'month'" do
      address.developer = true
      address.language = 'c'
      address.date = 'month'
      expect(address.generate_address).to eql('https://github.com/trending/developers/c?since=monthly')
    end

    it "Return request URI for developer trending when the language is not specified and the date is set to 'week'" do
      address.developer = true
      address.date = 'week'
      expect(address.generate_address).to eql('https://github.com/trending/developers?since=weekly')
    end

    it "Return request URI for developer trending when the language is not specified and the date is set to 'month'" do
      address.developer = true
      address.date = 'month'
      expect(address.generate_address).to eql('https://github.com/trending/developers?since=monthly')
    end
  end
end
