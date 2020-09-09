require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :request_uri , :informations, :developer
  def initialize
    @request_uri = ""
    @informations = []
    @developer = false
  end

  def scrap_page
    @informations = []
    if @developer
      scrap_developer_page
    else
      scrap_repo_page
    end
  end

  def scrap_developer_page
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

  def scrap_repo_page
    page = URI.open(@request_uri)
    doc = Nokogiri::HTML(page)

    element = doc.css("article")

    element.each_with_index do |trend,index|
      trend.css('float-right').remove
      # paragraph of description
      description = trend.css('p').text
      
      unless description.size == 0
        description = description.split(" ").join(" ")
      end 
      # owner
      title = trend.css("h1")
      title.css('svg').remove
      owner = title.css('span').text
      owner = owner.split(" ").join(" ")
      title.css("span").remove
      title = title.text
      title = title.split(" ").join("")
      # Programming language
      div = trend.xpath('div')[1]
      prog = div.css("span[itemprop='programmingLanguage']").text
      # Project stars number
      star = div.css("a")[0]
      star.css("svg")
      star = star.text.split(" ").join(" ")
      star = star.split(",").join("").to_i
      # Project members number
      member = div.css("a")[1]
      member.css("svg")
      member = member.text.split(" ").join(" ")
      member = member.split(",").join("").to_i
      # Project Builders
      builder_group = div.xpath("span")[-2].xpath("a")
      builders = []
      builder_group.each do |builder|
        builders.push("https://github.com" + builder['href'])
      end
      # Project stars today
      today = div.xpath("span")[-1]
      today.css("svg").remove
      today = today.text.split(" ")[0].split(",").join("").to_i
      # .bytes
      information = {
        owner: owner,
        title: title,
        description: description,
        member: member,
        programming_language: prog,
        stars_number: star,
        builders: builders,
        today_stars: today
      }
      @informations.push(information)
    end
  end

end