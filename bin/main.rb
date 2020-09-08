require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
page = URI.open('https://github.com/trending')
doc = Nokogiri::HTML(page)

element = doc.css("article")

element.each_with_index do |trend,index|
  trend.css('float-right').remove
  # paragraph of descroption
  description = trend.css('p').text
  
  unless description.size == 0
    description = description.split(" ").join(" ")
  end 
  
  # .bytes
  # owner
  title = trend.css("h1")
  title.css('svg').remove
  owner = title.css('span').text
  owner = owner.chomp
  owner2 = ""
  owner2 = owner2
  i=1
  while (owner[i].ord == 32) do
    i +=1
  end
  while i<owner.size do
    owner2 << owner[i]
    i +=1
  end
  owner = owner2
  # project title
  title.css("span").remove
  title = title.text
  title = title.split(" ").join("")
  # Programming language
  div = trend.xpath('div')[1]
  prog = div.css("span[itemprop='programmingLanguage']")
  # Project stars number
  star = div.css("a")[0]
  star.css("svg")
  star = star.text.split(" ").join(" ")
  star = star.split(",").join("").to_i
  # .bytes
  
  gets.chomp
end
