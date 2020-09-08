require 'nokogiri'
require 'open-uri'

class DeveloperScrap
  attr_accessor :request_uri , :informations
  def initialize
    @request_uri = ""
    @informations = []
  end

  def scrape_page
    page = URI.open(@request_uri)
    doc = Nokogiri::HTML(page)
    element = doc.xpath("//main/div/div/div/article")
    element.each do |trend|
      div = trend.css('div')[1]
      div = div.css("div")[0]
      div1 = div.css('div')[0]
      information = {}
      # Name
      name = div1.css("h1 a").text
      name = name.split(" ").join(" ")
      information['name'] = name
      # Profile name
      profile = div1.css("p a").text
      profile = profile.split(" ").join(" ")
      information['profile'] = profile if profile.length>0
      div2 = div.xpath('div')[1]
      div2 = div2.xpath('div')
      # company
      company = div2.xpath("p")
      if company.size > 0
        company = company.css('span').text
        information['company'] = company
        
      else
        article = div2.css('article')
        repository = article.css('h1 a')
        repository.css("svg").remove
        repository = repository.text.split(" ").join(" ")
        description = article.xpath("div")[1].text
        description = description.split(" ").join(" ")
        information['repository'] = repository
        information['description'] = description  
      end
      @informations.push(information)
    end
  end
end