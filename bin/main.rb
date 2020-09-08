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
  # Project members number
  member = div.css("a")[1]
  member.css("svg")
  member = member.text.split(" ").join(" ")
  member = member.split(",").join("").to_i
  # Project Builders
  builder_group = div.xpath("span")[1].xpath("a")
  builders = []
  builder_group.each do |builder|
    builders.push("https://github.com" + builder['href'])
  end
  # Project stars today
  today = div.xpath("span")[2]
  today.css("svg").remove
  today = today.text.split(" ")[0].split(",").join("").to_i
  # .bytes
  puts today.to_s + " ====> "+ index.to_s
  gets.chomp
end
